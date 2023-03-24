return {
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        terminal_colors = true,
        dim_inactive = true,
        module_default = true,
        styles = { -- Style to be applied to different syntax groups
          comments = "italic", -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "bold",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "bold",
          variables = "NONE",
        },
        inverse = { -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false,
        },
      },
      palettes = {},
      specs = {},
      groups = { all = { IndentBlanklineContextChar = { fg = "bg4" } } },
    },
    lazy = false,
    priority = 999,
    config = function(_, opts)
      local theme = require("nightfox")
      theme.setup(opts)
      vim.o.background = 'light'
      vim.cmd.colorscheme 'dawnfox'
    end,
  },
}
