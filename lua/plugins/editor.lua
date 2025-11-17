return {
  -- case aware search/replace
  { "tpope/vim-abolish", event = 'VeryLazy' },
  -- file mode utilities
  { "tpope/vim-eunuch",  event = 'VeryLazy' },
  -- goto file line numbers on startup
  { "wsdjeg/vim-fetch",  lazy = false },

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
    "OXY2DEV/markview.nvim",
    lazy = false,
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
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      use_diagnostic_signs = true,
    },
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end,
    },
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'Buffer Diagnostics (Trouble)'
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>st", function() require 'snacks'.picker.todo_comments() end,                                          desc = "Todo" },
      { "<leader>sT", function() require 'snacks'.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

  {
    'psliwka/vim-dirtytalk',
    ft = { 'python', 'lua', 'markdown', 'cpp', 'bash' },
    build = ':DirtytalkUpdate',
    init = function()
      vim.opt_local.spelllang = { 'en', 'programming' }
    end,
  },


  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'folke/snacks.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>G', function() require('neogit').open({ kind = 'auto' }) end, desc = 'Neogit' },
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
}
--
