return {
  "tpope/vim-abolish", -- case aware search/replace
  "tpope/vim-eunuch", -- file mode utilities
  "wsdjeg/vim-fetch", -- goto file line numbers on startup

  {
    "simnalamburt/vim-mundo",
    config = function(_, opts)
      vim.g.mundo_width = 30
      vim.g.mundo_preview_height = 40
      vim.g.mundo_preview_bottom = true
    end,
    keys = {
      { "<Leader>u", ":MundoToggle<CR>", noremap = true, desc = "Toggle: undo tree" },
    },
  },

  {
    "numToStr/Comment.nvim",
    opts = {
      pre_hook = function(ctx)
        local U = require("Comment.utils")
        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
          location = location,
        })
      end,
    },
  },

  {
    "tpope/vim-fugitive",
    keys = {
      { "<Leader>ge", "<cmd>Gedit :<CR>", desc = "Fugitive Gedit" },
    },
  },

  {
    "vim-scripts/a.vim",
    keys = {
      { "<C-H>", ":A<CR>", desc = "Switch to alternate buffer" },
    },
  },
}
