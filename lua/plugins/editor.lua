return {
  -- case aware search/replace
  { "tpope/vim-abolish", event = 'VeryLazy' },
  -- file mode utilities
  { "tpope/vim-eunuch", event = 'VeryLazy' },
  -- goto file line numbers on startup
  { "wsdjeg/vim-fetch", lazy = false },

  {
    "simnalamburt/vim-mundo",
    config = function()
      vim.g.mundo_width = 30
      vim.g.mundo_preview_height = 40
      vim.g.mundo_preview_bottom = true
    end,
    cmd = {'MundoToggle'},
    keys = {
      { "<Leader>u", ":MundoToggle<CR>", noremap = true, desc = "Toggle: undo tree" },
    },
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {}
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
    'kevinhwang91/nvim-bqf',
    dependencies = { 'junegunn/fzf' },
    ft = 'qf',
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    cmd = {'TroubleToggle', 'Trouble'},
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'Diagnostics (Trouble)' },
      { '<leader>xc', '<cmd>Trouble symbols toggle focus=false<CR>',
        desc = 'Symbols (Trouble)' },
      { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
        desc = 'LSP Definitions / references / ... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<CR>',
        desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<CR>',
        desc = 'Quickfix List (Trouble)' },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
    },
    opts = {},
  },

  {
    'psliwka/vim-dirtytalk',
    ft = { 'python', 'lua', 'markdown', 'cpp', 'bash' },
    build = ':DirtytalkUpdate',
    init = function()
      vim.opt_local.spelllang = {'en', 'programming'}
    end,
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
        "<leader>fh",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Show file history",
      },
      {
        "<leader>bh",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Show branch history",
      },
      {
        "<leader>dv",
        function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd('DiffviewOpen')
          else
            vim.cmd('DiffviewClose')
          end
        end,
        desc = "Toggle Diffview"
      },
    },
    opts = {},
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false
  },
}
--
