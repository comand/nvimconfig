return {
  -- case aware search/replace
  { "tpope/vim-abolish", event = 'VeryLazy' },
  -- file mode utilities
  { "tpope/vim-eunuch", event = 'VeryLazy' },
  -- goto file line numbers on startup
  { "wsdjeg/vim-fetch", lazy = false },

  -- disable plugins for big files
  {
    'LunarVim/bigfile.nvim',
    event = 'BufReadPre'
  },

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
    cmd = {'MundoToggle'},
    keys = {
      { "<Leader>u", ":MundoToggle<CR>", noremap = true, desc = "Toggle: undo tree" },
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          -- require('ts_context_commentstring').setup({
          --   enable_autocmd = true,
          -- })
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
    },
    event = "VeryLazy",
    opts = function ()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    main = 'mini.surround',
    opts = {
      mappings = {
        add = '<leader>sa',
        delete = '<leader>sd',
        find = '<leader>sf',
        find_left = '<leader>sF',
        highlight = '<leader>sh',
        replace = '<leader>sr',
        update_n_lines = '<leader>sn',
      },
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    cmd = {'TroubleToggle', 'Trouble'},
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'Diagnostics (Trouble)' },
      { '<leader>xc', '<cmd>Trouble symbols toggle focus=false<CR>',
        desc = 'Symbols (Trouble)' },
      { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
        desc = 'LSP Definitions / references / ... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<CR>',
        desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<CR>',
        desc = 'Quickfix List (Trouble)' },
      -- { '[q',
      --   function()
      --     require('trouble').open()
      --     require('trouble').previous({ skip_groups = true, jump = true })
      --   end,
      --   desc = 'Previous trouble/quickfix item',
      -- },
      -- { ']q',
      --   function()
      --     require('trouble').open()
      --     require('trouble').next({ skip_groups = true, jump = true })
      --   end,
      --   desc = 'Next trouble/quickfix item',
      -- },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
    },
    opts = {},
  },

  {
    'psliwka/vim-dirtytalk',
    ft = { 'python', 'lua', 'markdown', 'cpp', 'bash' },
    build = ':DirtytalkUpdate',
    init = function()
      vim.opt_local.spelllang = {'en', 'programming'}
    end,
  },


  {
    "tpope/vim-fugitive",
    event = 'VeryLazy',
    keys = {
      { "<Leader>ge", "<cmd>Gedit :<CR>", desc = "Fugitive Gedit" },
    },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>fh",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Show file history",
      },
      {
        "<leader>bh",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Show branch history",
      },
      {
        "<leader>dv",
        function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd('DiffviewOpen')
          else
            vim.cmd('DiffviewClose')
          end
        end,
        desc = "Toggle Diffview"
      },
    },
    opts = {},
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    'ii14/neorepl.nvim',
    cmd = { 'Repl' },
    keys = {
      {
        '<leader>re',
        function()
          -- get current buffer and window
          local buf = vim.api.nvim_get_current_buf()
          local win = vim.api.nvim_get_current_win()
          -- create a new split for the repl
          vim.cmd('split')
          -- spawn repl and set the context to our buffer
          require('neorepl').new{
            lang = 'vim',
            buffer = buf,
            window = win,
          }
          -- resize repl window and make it fixed height
          vim.cmd('resize 10 | setl winfixheight')
        end,
        desc = 'Neorepl'
      },
    }
  },
}
--
