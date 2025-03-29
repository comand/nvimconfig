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
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { '<leader>a', '<cmd>AerialToggle<cr>',
        noremap = true, silent = true, desc = 'Symbol navigator'
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      -- LSP
      {'williamboman/mason.nvim', cmd = 'Mason',
        config = function() require('mason').setup() end },
      'williamboman/mason-lspconfig.nvim',
      'p00f/clangd_extensions.nvim',
      {'j-hui/fidget.nvim', opts = {} },
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

      servers = {
        bashls = {},
        clangd = {},
        jsonls = {},
        rust_analyzer = {},

        pyright = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = 'off',
            },
          },
        },

        lua_ls = {
          Lua = {
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              checkThirdParty = false,
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
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

      local on_attach = function(client, bufnr)
        -- Illuminate
        require('illuminate').on_attach(client)

        -- Set the tagfunc to use lsp-definition
        vim.api.nvim_set_option_value(
          'tagfunc', 'v:lua.vim.lsp.tagfunc', { buf = bufnr })

        -- Bind LSP keys
        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs,
            { remap = false, silent = true, buffer = bufnr, desc = desc })
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
        map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: [c]ode [a]ction')
        map('n', '<leader>cf', vim.lsp.buf.format, 'LSP: [c]ode [f]ormatting')
        vim.keymap.set('v', '<leader>cf', vim.lsp.buf.format,
          { silent = true, desc = 'LSP: [c]ode [f]ormatting' })

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

      -- Set up diagnostics.
      vim.diagnostic.config(opts.diagnostic)

      -- LSP config
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(opts.servers)
      }

      local make_server_args = function(server_name, default_args)
        local has_site, site = pcall(require, 'config.site.lsp.' .. server_name)
        if has_site then
          return site.make_server_args(default_args)
        end
        return default_args
      end

      mason_lspconfig.setup_handlers {
        -- Default config
        function(server_name)
          require('lspconfig')[server_name].setup(
            make_server_args(
              server_name,
              {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = opts.servers[server_name],
                flags = { debounce_text_changes = 150 },
              }
            )
          )
        end,

        -- Custom configs
        ['clangd'] = function ()
          require('lspconfig')['clangd'].setup {
              cmd = {'clangd', '--enable-config', '--limit-results=0'},
              capabilities = vim.tbl_extend('keep', capabilities, {
                offsetEncoding = 'utf-16',
              }),
              settings = opts.servers['clangd'],
              flags = { debounce_text_changes = 150 },
              on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.keymap.set('n', '<C-H>', ':ClangdSwitchSourceHeader<CR>',
                  { remap = true, silent = true, buffer = bufnr,
                    desc = 'Switch to source/header file' })
              end,
            }
        end,
      }

    end,
  },
}
