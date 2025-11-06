return {
  {
    'stevearc/aerial.nvim',
    opts = {
      layout = {
        max_width = { 80, 0.3 },
        min_width = 10,
        width = 80,
      },
      show_guides = true,
      keymaps = {
        ["}"] = false,
        ["{"] = false,
        ["<C-k>"] = "actions.prev",
        ["<C-j>"] = "actions.next",
      },
    },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", branch = 'master' },
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      {
        '<leader>a',
        '<cmd>AerialToggle<cr>',
        noremap = true,
        silent = true,
        desc = 'Symbol navigator'
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- LSP
      {
        'mason-org/mason.nvim',
        cmd = 'Mason',
        config = function() require('mason').setup() end
      },
      'p00f/clangd_extensions.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },

    opts = {
      diagnostic = {
        signs = {
          active = true,
          text = {
            [vim.diagnostic.severity.ERROR] = require('config.icons').diagnostics.error,
            [vim.diagnostic.severity.WARN] = require('config.icons').diagnostics.warn,
            [vim.diagnostic.severity.HINT] = require('config.icons').diagnostics.hint,
            [vim.diagnostic.severity.INFO] = require('config.icons').diagnostics.info,
          },
        },
        virtual_text = true,
        -- virtual_lines = false,
        update_in_insert = false,
        underline = { severity = { min = vim.diagnostic.severity.WARN } },
        severity_sort = true,
        jump = { float = true },
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      },
    },

    config = function(_, opts)
      -- Logs get huge very quickly -- set "debug" for debugging.
      vim.lsp.set_log_level("off")

      local function bordered_hover(_opts)
        _opts = _opts or {}
        return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, {
          border = "rounded",
        }))
      end

      local function bordered_signature_help(_opts)
        _opts = _opts or {}
        return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", _opts, {
          border = "rounded",
        }))
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Set up diagnostics.
      vim.diagnostic.config(opts.diagnostic)

      -- Unbind neovim's default LSP keys
      vim.keymap.del('n', 'grn')
      vim.keymap.del({ 'n', 'x' }, 'gra')
      vim.keymap.del('n', 'grr')
      vim.keymap.del('n', 'gri')
      vim.keymap.del('n', 'gO')
      vim.keymap.del({ 'i', 's' }, '<C-S>')

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          -- Set the tagfunc to use lsp-definition
          vim.api.nvim_set_option_value(
            'tagfunc', 'v:lua.vim.lsp.tagfunc', { buf = ev.buf })


          -- Bind LSP keys
          local map = function(m, lhs, rhs, desc)
            vim.keymap.set(m, lhs, rhs,
              { remap = false, silent = true, buffer = ev.buf, desc = desc })
          end

          map('n', '<Tab>d', function()
            local vtext = not vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_text = vtext })
          end, 'Toggle virtual diagnostic text')

          map('n', '<Tab>v', function()
            local vlines = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config({ virtual_lines = vlines })
          end, 'Toggle virtual diagnostic lines')

          map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: [r]e[n]ame')
          -- map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: [c]ode [a]ction')
          map('n', '<leader>ca', function()
            require('tiny-code-action').code_action()
          end, 'LSP: [c]ode [a]ction')
          map('n', '<leader>cf', vim.lsp.buf.format, 'LSP: [c]ode [f]ormatting')
          map({ 'n', 'v' }, '<leader>cf', vim.lsp.buf.format, 'LSP: [c]ode [f]ormatting')
          map('n', 'K', bordered_hover, 'Show information')
          map('n', '<C-,>', function()
            vim.diagnostic.open_float(nil, { scope = 'line' })
          end, 'Show diagnostics')

          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('n', 'go', vim.lsp.buf.type_definition, 'Go to type definition')
          map('n', 'gr',
            require('telescope.builtin').lsp_references, 'Show references')
          map('n', '<leader>ds',
            require('telescope.builtin').lsp_document_symbols, 'Document symbols')
          map('n', '<C-k>', bordered_signature_help, 'Signature documentation')
        end
      })
    end,
  },

  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          "bashls",
          "clangd",
          "jsonls",
          "rust_analyzer",
          "pyright",
          "lua_ls",
        },
        automatic_enable = true,
      }
    end
  },

  {
    'rachartier/tiny-code-action.nvim',
    event = 'LspAttach',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    opts = {
      backend = 'difftastic',
      picker = 'telescope',
    },
  },
}
