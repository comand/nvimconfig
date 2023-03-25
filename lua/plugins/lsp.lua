local servers = {
  'bashls',
  'clangd',
  'jsonls',
  'pyright',
  'rust_analyzer',
  'lua_ls',
  --'ruff_lsp',
}

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      -- LSP
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'p00f/clangd_extensions.nvim',
      'ray-x/lsp_signature.nvim',
      {'j-hui/fidget.nvim', opts = {} },

      -- Completion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- Snippets
      'SirVer/UltiSnips',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'honza/vim-snippets',

      'folke/neodev.nvim',
    },

    opts = {
      preset = {
        name = 'minimal',
        set_lsp_keymaps = false,
        manage_nvim_cmp = false,
        suggest_lsp_servers = false,
      },

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

    config= function(_, opts)
      local lsp = require('lsp-zero')
      lsp.preset(opts.preset)

      local ensure_installed = {}
      for server,_ in pairs(opts.servers) do
        table.insert(ensure_installed, server)
      end
      lsp.ensure_installed(ensure_installed)

      local cmp = require('cmp')
      local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
      local mappings = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable, -- remove the default `<C-y>` mapping.
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end, { "i", "s" }),
      }

      for server,config in pairs(opts.servers) do
        lsp.configure(server, config)
      end

      local cmp_config = lsp.defaults.cmp_config {
        snippet = {
          expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = lsp.defaults.cmp_mappings(mappings),
        formatting = {
          fields = { "kind", "abbr", "menu" }, -- put the icon first
          format = function(entry, item)
            local icons = require('config.icons').kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. ' ' .. item.kind
            end
            item.menu = ({
              nvim_lsp = "[LSP]",
              ultisnips = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source_name]
            return item
          end,
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require('clangd_extensions').cmp_scores,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "ultisnips" },
          { name = "buffer" },
          { name = "path" },
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        experimental = {
          ghost_text = { hl_group = "LspCodeLens" },
          native_menu = false,
        },
      }
      cmp.setup(cmp_config)

      lsp.on_attach(function(client, bufnr)
        require('lsp_signature').on_attach({
          bind = true,
          hint_enable = false,
          doc_lines = 3,
        }, bufnr)

        -- set the tagfunc to use lsp-definition
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
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature documentation')

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
            callback = vim.slp.buf.clear_references,
            buffer = bufnr,
            group = 'lsp_document_highlight',
            desc = 'Clear All References',
          })
        end
        lsp.setup()

        -- Setup diganostics
        vim.diagnostic.config(opts.diagnostic)
      end)
    end,
  },
}
