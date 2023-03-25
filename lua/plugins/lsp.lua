return {
  {
    'neovim/nvim-lspconfig',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      -- LSP
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'p00f/clangd_extensions.nvim',
      'ray-x/lsp_signature.nvim',
      {'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
    },

    opts = {
      diagnostic = {
        underline = { severity = { min = vim.diagnostic.severity.WARN } },
        update_in_insert = true,
        virtual_text = { spacing = 4, prefix = '●' },
        severity_sort = true,
      },

      servers = {
        bashls = {},
        clangd = {},
        jsonls = {},

        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'off',
              },
            },
          },
        },

        lua_ls = {
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },

        rust_analyzer = {},
      },
    },

    config = function(_, opts)
      require('neodev').setup()

      -- Language Server
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(opts.servers)
      }

      local on_attach = function(client, bufnr)
        -- LSP signature
        require('lsp_signature').on_attach({
          bind = true,
          hint_enable = false,
          doc_lines = 3,
        }, bufnr)

        -- set the tagfunc to use lsp-definition
        vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs,
            { remap = false, silent = true, buffer = bufnr, desc = desc })
        end

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
        map('n', '<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
        map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature documentation')

        -- Set up LSP highlight if available
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
          vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight' })
          vim.api.nvim_create_autocmd('CursorHold', {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = 'lsp_document_highlight',
            desc = 'Document Highlight',
          })
          vim.api.nvim_create_autocmd('CursorMoved', {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = 'lsp_document_highlight',
            desc = 'Clear All References',
          })
        end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = opts.servers[server_name],
          }
        end,
      }

      -- Set up diagnostics
      vim.diagnostic.config(opts.diagnostic)
    end,
  },
}
