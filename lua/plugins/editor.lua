return {
  "tpope/vim-abolish",      -- case aware search/replace
  "tpope/vim-eunuch",       -- file mode utilities
  "wsdjeg/vim-fetch",       -- goto file line numbers on startup
  'sam4llis/nvim-lua-gf',   -- gf for lua imports/requires

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
      { '<leader>m', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Show document diagnostics' },
      { '<leader>M', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Show workspace diagnostics' },
      { '<leader>L', '<cmd>TroubleToggle loclist<CR>', desc = 'Show location list' },
      { '<leader>U', '<cmd>TroubleToggle quickfix<CR>', desc = 'Show quickfix list' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            local ok, _ = pcall(vim.cmd, 'cprev')
            if not ok then
              ok, _ = pcall(vim.cmd, 'clast')
              if not ok then
                  print('No errors')
              end
            end
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            local ok, _ = pcall(vim.cmd, 'cnext')
            if not ok then
              ok, _ = pcall(vim.cmd, 'cfirst')
              if not ok then
                  print('No errors')
              end
            end
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },

  {
    "tpope/vim-fugitive",
    keys = {
      { "<Leader>ge", "<cmd>Gedit :<CR>", desc = "Fugitive Gedit" },
    },
  },
}
