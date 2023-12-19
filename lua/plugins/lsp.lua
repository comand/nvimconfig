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
      { 'williamboman/mason.nvim', cmd = 'Mason',
        config = function() require('mason').setup() end },
      'williamboman/mason-lspconfig.nvim',
      'p00f/clangd_extensions.nvim',
      {'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
        config = function() require('toggle_lsp_diagnostics').init() end },
      {'j-hui/fidget.nvim', opts = {} },
    },

    opts = {
      diagnostic = {
        signs = true,
        sign_icons = {
          { name = 'DiagnosticSignError', text = require('config.icons').diagnostics.error },
          { name = 'DiagnosticSignWarn',  text = require('config.icons').diagnostics.warn  },
          { name = 'DiagnosticSignHint',  text = require('config.icons').diagnostics.hint  },
          { name = 'DiagnosticSignInfo',  text = require('config.icons').diagnostics.info  },
        },
        update_in_insert = false,
        underline = { severity = { min = vim.diagnostic.severity.WARN } },
        severity_sort = true,
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
      local on_attach = function(client, bufnr)
        -- Illuminate
        require('illuminate').on_attach(client)

        -- Set the tagfunc to use lsp-definition
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

        -- Bind LSP keys
        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs,
            { remap = false, silent = true, buffer = bufnr, desc = desc })
        end

        map('n', '<Tab>v',
          require'toggle_lsp_diagnostics'.toggle_virtual_text,
          'Toggle diagnostic vtext')

        map('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: [r]e[n]ame')
        map('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: [c]ode [a]ction')

        map('n', 'K', vim.lsp.buf.hover, 'Show information')
        map('n', '<C-,>', function()
            vim.diagnostic.open_float(nil, { scope = 'line' })
          end, 'Show diagnostics')
        map('n', '[,', vim.diagnostic.goto_prev, 'Previous diagnostic')
        map('n', '],', vim.diagnostic.goto_next, 'Next diagnostic')

        map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('n', 'go', vim.lsp.buf.type_definition, 'Go to type definition')
        map('n', 'gr',
          require('telescope.builtin').lsp_references, 'Show references')
        map('n', '<leader>ds',
          require('telescope.builtin').lsp_document_symbols, 'Document symbols')
        --[[ map('n', '<leader>ws', ]]
        --[[   require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols') ]]
        map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature documentation')
      end

      -- Set up diagnostics.
      vim.diagnostic.config(opts.diagnostic)
      for _, sign in ipairs(opts.diagnostic.sign_icons) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
      end

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
        width = 60,
      })
      vim.lsp.signatureHelp = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
        width = 60,
      })

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
              capabilities = capabilities,
              settings = opts.servers['clangd'],
              flags = { debounce_text_changes = 150 },
              on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                require('clangd_extensions.inlay_hints').setup_autocmd()
                require('clangd_extensions.inlay_hints').set_inlay_hints()
                vim.keymap.set('n', '<C-H>', function()
                  client.request('textDocument/switchSourceHeader',
                    { uri = vim.uri_from_bufnr(bufnr) },
                    function(err, result)
                      if err then
                        error(tostring(err))
                      end
                      if not result then
                        print 'Corresponding file cannot be determined'
                        return
                      end
                      vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
                    end, bufnr)
                end,
                  { remap = true, silent = true, buffer = bufnr,
                    desc = 'Switch to source/header file' })
              end,
              }
        end,
      }

    end,
  },
}
