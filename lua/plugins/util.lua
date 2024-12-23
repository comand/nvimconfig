return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "vhyrro/luarocks.nvim",
    lazy = false,
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    opts = {
      rocks = {"tiktoken_core"},
      luarocks_build_args = { "--with-lua=/bin/lua-5.1" },
    },
  },
}
