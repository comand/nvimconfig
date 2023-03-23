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
    'neovim/nvim-lspconfig',
    --event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'j-hui/fidget.nvim',
      'p00f/clangd_extensions.nvim',
    },

    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = '●' },
        severity_sort = true,
      },
    },

    config = function(_, opts)
      require('mason').setup(opts)
      require('mason-lspconfig').setup { ensure_installed = servers }

      local lspconfig = require('lspconfig')
      local handlers = require('plugins.lsp.handlers')
      handlers.setup()
      for _, server in pairs(servers) do
        local s_opts = {
          on_attach = handlers.on_attach,
          capabilities = handlers.capabilities,
        }
        local has_custom_opts, server_custom_opts = pcall(require, 'plugins.lsp.settings.' .. server)
        if has_custom_opts then
          s_opts = vim.tbl_deep_extend('force', s_opts, server_custom_opts)
        end
        lspconfig[server].setup(s_opts)
      end
    end
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function(_, opts)
      require('mason-null-ls').setup {
        automatic_setup = true
      }
    end
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      vim.keymap.set('n', '<leader>xx', require'trouble'.toggle, { noremap = true, desc = 'Trouble: toggle list' })
    end,
  },
}
