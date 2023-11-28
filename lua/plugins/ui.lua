return {
  'kyazdani42/nvim-web-devicons',   -- file type icons, etc.

  {
    "rcarriga/nvim-notify",
    event = 'VeryLazy',
    keys = {
      {
        "<Leader>nd",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      local nvim_notify = require('notify')
      nvim_notify.setup(opts)
      vim.notify = nvim_notify
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = 'VeryLazy',
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = 'VeryLazy',
    dependencies = {
      "stevearc/aerial.nvim",
    },
    opts = {
      extensions = {
        "fugitive",
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
    "lukas-reineke/indent-blankline.nvim",
    main = 'ibl',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<Tab>b", ':IBLToggle<CR>', desc = "Toggle indent-blankline" },
    },
    opts = {
      scope = { enabled = false },
      indent = { char = {"│"} },
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
    end
  },

  {
    "anuvyklack/pretty-fold.nvim",
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      "anuvyklack/nvim-keymap-amend",
    },
    opts = {
      fill_char = "╌",
      process_comment_signs = "delete",
      sections = {
        left = {
          "»",
          "content",
        },
        right = {
          " ",
          "number_of_folded_lines",
          " ",
        },
      },
    },
  },
}
