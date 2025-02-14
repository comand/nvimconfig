return {
  {
    "EdenEast/nightfox.nvim",
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
