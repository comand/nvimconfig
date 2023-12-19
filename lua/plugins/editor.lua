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
      { '[q',
        function()
          require('trouble').open()
          require('trouble').previous({ skip_groups = true, jump = true })
        end,
        desc = 'Previous trouble/quickfix item',
      },
      { ']q',
        function()
          require('trouble').open()
          require('trouble').next({ skip_groups = true, jump = true })
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
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
}
