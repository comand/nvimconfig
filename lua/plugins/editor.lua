return {
  -- case aware search/replace
  { "tpope/vim-abolish", event = 'VeryLazy' },
  -- file mode utilities
  { "tpope/vim-eunuch", event = 'VeryLazy' },
  -- goto file line numbers on startup
  { "wsdjeg/vim-fetch", lazy = false },

  -- gf for lua imports/requires
  {
    'sam4llis/nvim-lua-gf',
    ft = {'lua'},
    event = 'VeryLazy',
  },

  {
    "simnalamburt/vim-mundo",
    config = function()
      vim.g.mundo_width = 30
      vim.g.mundo_preview_height = 40
      vim.g.mundo_preview_bottom = true
    end,
    cmds = {'MudoToggle'},
    keys = {
      { "<Leader>u", ":MundoToggle<CR>", noremap = true, desc = "Toggle: undo tree" },
    },
  },

  {
    "numToStr/Comment.nvim",
    event = 'BufReadPost',
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
    "echasnovski/mini.surround",
    event = "BufReadPost",
    version = false,
    opts = {},
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    cmd = {'TroubleToggle', 'Trouble'},
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>x', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Show document diagnostics' },
      { '<leader>X', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Show workspace diagnostics' },
      { '<leader>L', '<cmd>TroubleToggle loclist<CR>', desc = 'Show location list' },
      { '<leader>U', '<cmd>TroubleToggle quickfix<CR>', desc = 'Show quickfix list' },
    },
  },

  {
    "tpope/vim-fugitive",
    event = 'VeryLazy',
    keys = {
      { "<Leader>ge", "<cmd>Gedit :<CR>", desc = "Fugitive Gedit" },
    },
  },
}
