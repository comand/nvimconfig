return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
  },
  {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "doxygen",
        "glsl",
        "go",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "python",
        "query",
        "regex",
        "rst",
        "rust",
        "toml",
        "typst",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      -- fold = { enable = true },
      highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = { "python" }
      },
      indent = { enable = true },
      -- incremental_selection = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ["@function.outer"] = 'V', -- linewise
        },
      },
      move = {
        set_jumps = true,
      },
    },
    config = function(_, opts)
      require "nvim-treesitter-textobjects".setup {opts}

      -- select
      local select = require "nvim-treesitter-textobjects.select"
      for _, mode in ipairs({ "x", "o" }) do
        -- [a]rgument
        vim.keymap.set(mode, "aa", function()
          select.select_textobject("@parameter.outer", "textobjects")
        end, { desc = "textobject: outer [a]rgument" })
        vim.keymap.set(mode, "ia", function()
          select.select_textobject("@parameter.inner", "textobjects")
        end, { desc = "textobject: inner [a]rgument" })
        -- [b]lock
        vim.keymap.set(mode, "ab", function()
          select.select_textobject("@block.outer", "textobjects")
        end, { desc = "textobject: outer [b]lock" })
        vim.keymap.set(mode, "ib", function()
          select.select_textobject("@block.inner", "textobjects")
        end, { desc = "textobject: inner [b]lock" })
        -- [m]ethod
        vim.keymap.set(mode, "am", function()
          select.select_textobject("@function.outer", "textobjects")
        end, { desc = "textobject: outer [m]ethod" })
        vim.keymap.set(mode, "im", function()
          select.select_textobject("@function.inner", "textobjects")
        end, { desc = "textobject: inner [m]ethod" })
        -- c[l]ass
        vim.keymap.set(mode, "al", function()
          select.select_textobject("@class.outer", "textobjects")
        end, { desc = "textobject: outer c[l]ass" })
        vim.keymap.set(mode, "il", function()
          select.select_textobject("@class.inner", "textobjects")
        end, { desc = "textobject: inner c[l]ass" })
        -- [f]unction call
        vim.keymap.set(mode, "af", function()
          select.select_textobject("@call.outer", "textobjects")
        end, { desc = "textobject: outer [f]unction call" })
        vim.keymap.set(mode, "if", function()
          select.select_textobject("@call.inner", "textobjects")
        end, { desc = "textobject: inner [f]unction call" })
        -- l[o]op
        vim.keymap.set(mode, "ao", function()
          select.select_textobject("@loop.outer", "textobjects")
        end, { desc = "textobject: outer [l]oop" })
        vim.keymap.set(mode, "io", function()
          select.select_textobject("@loop.inner", "textobjects")
        end, { desc = "textobject: inner [l]oop" })
        -- [c]omment
        vim.keymap.set(mode, "ac", function()
          select.select_textobject("@comment.outer", "textobjects")
        end, { desc = "textobject: outer [c]omment" })
      end

      -- swap
      local swap = require "nvim-treesitter-textobjects.swap"
      vim.keymap.set("n", ")m", function()
        swap.swap_next("@function.outer")
      end, { desc = "textobject: swap next [m]ethod" })
      vim.keymap.set("n", "(m", function()
        swap.swap_next("@function.outer")
      end, { desc = "textobject: swap previous [m]ethod" })
      vim.keymap.set("n", ")a", function()
        swap.swap_next("@parameter.outer")
      end, { desc = "textobject: swap next [a]rgument" })
      vim.keymap.set("n", "(a", function()
        swap.swap_next("@parameter.outer")
      end, { desc = "textobject: swap previous [a]rgument" })

      -- move
      local move = require "nvim-treesitter-textobjects.move"
      -- [m]ethod
      vim.keymap.set({"n", "x", "o"}, "]m", function()
        move.goto_next_start("@function.outer")
      end, { desc = "textobject: goto next [m]ethod start" })
      vim.keymap.set({"n", "x", "o"}, "]M", function()
        move.goto_next_end("@function.outer")
      end, { desc = "textobject: goto next [m]ethod end" })
      vim.keymap.set({"n", "x", "o"}, "[m", function()
        move.goto_previous_start("@function.outer")
      end, { desc = "textobject: goto previous [m]ethod start" })
      vim.keymap.set({"n", "x", "o"}, "[M", function()
        move.goto_previous_end("@function.outer")
      end, { desc = "textobject: goto previous [m]ethod end" })
      -- c[l]ass
      vim.keymap.set({"n", "x", "o"}, "]l", function()
        move.goto_next_start("@class.outer")
      end, { desc = "textobject: goto next c[l]ass start" })
      vim.keymap.set({"n", "x", "o"}, "]L", function()
        move.goto_next_end("@class.outer")
      end, { desc = "textobject: goto next c[l]ass end" })
      vim.keymap.set({"n", "x", "o"}, "[l", function()
        move.goto_previous_start("@class.outer")
      end, { desc = "textobject: goto previous c[l]ass start" })
      vim.keymap.set({"n", "x", "o"}, "[L", function()
        move.goto_previous_end("@class.outer")
      end, { desc = "textobject: goto previous c[l]ass end" })

    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false,
  },
}
