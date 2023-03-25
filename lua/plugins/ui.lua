return {
  'kyazdani42/nvim-web-devicons',   -- file type icons, etc.

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<Leader>un",
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
  },

  {
    "stevearc/dressing.nvim",
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
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      local navic = require("nvim-navic")
      require("lualine").setup({
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
            "branch",
            "diagnostics",
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 1,
              symbols = {
                modified = " ",
                readonly = " ",
              },
            },
            { navic.get_location, cond = navic.is_available },
          },
          lualine_x = {
            "filetype",
          },
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      show_current_context = true,
      show_end_of_line = false,
      use_treesitter = true,
      filetype = { "vim", "python", "lua", "yaml", "json" },
    },
  },

  {
    "chentoast/marks.nvim",
    opts = {
      default_mappings = true,
      signs = true,
      mappings = {},
    },
  },

  {
    "mhinz/vim-signify",
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
    config = function()
      vim.g.Illuminate_delay = 500
    end,
  },

  {
    "anuvyklack/pretty-fold.nvim",
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
