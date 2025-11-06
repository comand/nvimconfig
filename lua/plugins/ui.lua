return {
  'nvim-tree/nvim-web-devicons', -- file type icons, etc.

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<Leader>n",
        function()
          require('snacks').notifier.show_history()
        end,
        desc = 'Show notification history'
      },
      {
        "<Tab>b",
        function()
          local snacks = require('snacks')
          if snacks.indent.enabled then
            snacks.indent.disable()
          else
            snacks.indent.enable()
          end
        end,
        desc = 'Toggle indent guides'
      },
    },
    opts = {
      bigfile = { enabled = true },
      indent = {
        enabled = true,
        animate = { enabled = false },
        char = "│",
      },
      input = { enabled = true },
      notifier = { enabled = true, style = 'fancy' },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = 'VeryLazy',
    dependencies = {
      "stevearc/aerial.nvim",
    },
    opts = {
      extensions = {
        "man",
        "mundo",
        "quickfix",
        "toggleterm",
      },
      disabled_filetypes = {
        statusline = {},
        winbar = {
          "help",
          "Trouble",
          "packer",
          "toggleterm",
        },
      },
      sections = {
        lualine_b = {
          {
            "branch",
            icon = require('config.icons').git.branch .. ' ',
          },
          {
            "diagnostics",
            symbols = {
              error = require('config.icons').diagnostics.error,
              warn = require('config.icons').diagnostics.warn,
              info = require('config.icons').diagnostics.info,
              hint = require('config.icons').diagnostics.hint,
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
            symbols = {
              modified = require('config.icons').file.modified .. ' ',
              readonly = require('config.icons').file.readonly .. ' ',
              unnamed = '',
              newfile = require('config.icons').file.new .. ' ',
            },
          },
          { "aerial" },
        },
        lualine_x = {
          { "filetype", icon_only = true, separator = '' },
        },
      },
    },
  },

  {
    "chentoast/marks.nvim",
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      default_mappings = true,
      signs = true,
      mappings = {},
    },
  },

  {
    "mhinz/vim-signify",
    lazy = false,
    config = function()
      vim.g.signify_sign_add = "┃"
      vim.g.signify_sign_delete_first_line = "ᐅ"
      vim.g.signify_sign_change = "┇"
      vim.g.signify_sign_delete = "┃"
      vim.g.signify_sign_show_count = false
      vim.cmd([[
      highlight SignifySignAdd    ctermfg=DarkGreen  guifg=#169135 cterm=NONE gui=NONE
      highlight SignifySignChange ctermfg=DarkGreen  guifg=#169135 cterm=NONE gui=NONE
      highlight SignifySignDelete ctermfg=DarkRed    guifg=#b02e3b cterm=NONE gui=NONE
      highlight SignifySignChange ctermfg=DarkYellow guifg=#c7c92c cterm=NONE gui=NONE
      ]])
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 500,
      under_cursor = false,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
    keys = {
      { "<Tab>i", ":IlluminateToggleBuf<CR>", desc = "Toggle illuminate" },
    },
  },
}
