return {
  -- case aware search/replace
  { "tpope/vim-abolish", event = 'VeryLazy' },
  -- file mode utilities
  { "tpope/vim-eunuch", event = 'VeryLazy' },
  -- goto file line numbers on startup
  { "wsdjeg/vim-fetch", lazy = false },

  -- gf for lua imports/requires
  {
    'sam4llis/nvim-lua-gf',
    ft = {'lua'},
    event = 'VeryLazy',
  },

  {
    "simnalamburt/vim-mundo",
    config = function()
      vim.g.mundo_width = 30
      vim.g.mundo_preview_height = 40
      vim.g.mundo_preview_bottom = true
    end,
    cmds = {'MudoToggle'},
    keys = {
      { "<Leader>u", ":MundoToggle<CR>", noremap = true, desc = "Toggle: undo tree" },
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = {
    "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "VeryLazy",
    opts = function ()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    main = 'mini.surround',
    opts = {
      mappings = {
        add = '<leader>sa',
        delete = '<leader>sd',
        find = '<leader>sf',
        find_left = '<leader>sF',
        highlight = '<leader>sh',
        replace = '<leader>sr',
        update_n_lines = '<leader>sn',
      },
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    cmd = {'TroubleToggle', 'Trouble'},
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>x', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Show document diagnostics' },
      { '<leader>X', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Show workspace diagnostics' },
      { '<leader>L', '<cmd>TroubleToggle loclist<CR>', desc = 'Show location list' },
      { '<leader>U', '<cmd>TroubleToggle quickfix<CR>', desc = 'Show quickfix list' },
    },
  },

  {
    "tpope/vim-fugitive",
    event = 'VeryLazy',
    keys = {
      { "<Leader>ge", "<cmd>Gedit :<CR>", desc = "Fugitive Gedit" },
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>hv",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Show file history",
      },
      {
        "<leader>hV",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Show branch history",
      },
    },
    opts = {},
  },
}
