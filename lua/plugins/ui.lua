return {
  'nvim-tree/nvim-web-devicons', -- file type icons, etc.

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      indent = {
        enabled = true,
        animate = { enabled = false },
        char = "│",
      },
      input = { enabled = true },
      notifier = { enabled = true, style = 'fancy' },
      picker = { enabled = true },
      explorer = { enabled = true },
    },
    config = function(opts, _)
      require 'snacks'.setup {opts}

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, 'SnacksPickerPreview', { bg = 'none', nocombine = true })
          vim.api.nvim_set_hl(0, 'SnacksPickerList', { bg = 'none', nocombine = true })
          vim.api.nvim_set_hl(0, 'SnacksPickerInput', { bg = 'none', nocombine = true })
          vim.api.nvim_set_hl(0, 'SnacksPickerInputBorder', { bg = 'none', nocombine = true  })
        end,
      })
    end,
    keys = {
      {
        "<Tab>i",
        function()
          local snacks = require('snacks')
          if snacks.indent.enabled then
            snacks.indent.disable()
          else
            snacks.indent.enable()
          end
        end,
        desc = 'Toggle indent guides'
      },
      -- Top Pickers & Explorer
      { "<leader><space>", function() require'snacks'.picker.smart() end, desc = "Smart Find Files" },
      { "<C-e>",      function() require'snacks'.picker.files() end, desc = "Find Files" },
      { "<C-b>", function() require'snacks'.picker.buffers() end, desc = "Buffers" },
      { "<C-g>", function() require'snacks'.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() require'snacks'.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() require'snacks'.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() require'snacks'.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fc", function() require'snacks'.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>fg", function() require'snacks'.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() require'snacks'.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gb", function() require'snacks'.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() require'snacks'.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() require'snacks'.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() require'snacks'.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() require'snacks'.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() require'snacks'.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() require'snacks'.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() require'snacks'.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() require'snacks'.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sw", function() require'snacks'.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() require'snacks'.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() require'snacks'.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() require'snacks'.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sb", function() require'snacks'.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sc", function() require'snacks'.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() require'snacks'.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() require'snacks'.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() require'snacks'.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() require'snacks'.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() require'snacks'.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() require'snacks'.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() require'snacks'.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() require'snacks'.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() require'snacks'.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() require'snacks'.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() require'snacks'.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() require'snacks'.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() require'snacks'.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() require'snacks'.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() require'snacks'.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() require'snacks'.picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() require'snacks'.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() require'snacks'.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() require'snacks'.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() require'snacks'.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() require'snacks'.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "gai", function() require'snacks'.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
      { "gao", function() require'snacks'.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
      { "<leader>ss", function() require'snacks'.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() require'snacks'.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = 'VeryLazy',
    dependencies = {
      "stevearc/aerial.nvim",
    },
    opts = {
      extensions = {
        "man",
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
          {
            "branch",
            icon = require('config.icons').git.branch .. ' ',
          },
          {
            "diagnostics",
            symbols = {
              error = require('config.icons').diagnostics.error,
              warn = require('config.icons').diagnostics.warn,
              info = require('config.icons').diagnostics.info,
              hint = require('config.icons').diagnostics.hint,
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
            symbols = {
              modified = require('config.icons').file.modified .. ' ',
              readonly = require('config.icons').file.readonly .. ' ',
              unnamed = '',
              newfile = require('config.icons').file.new .. ' ',
            },
          },
          { "aerial" },
        },
        lualine_x = {
          { "filetype", icon_only = true, separator = '' },
        },
      },
    },
  },

  {
    "chentoast/marks.nvim",
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      default_mappings = true,
      signs = true,
      mappings = {},
    },
  },

  {
    "mhinz/vim-signify",
    lazy = false,
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
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 500,
      under_cursor = false,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
    keys = {
      { "<Tab>i", ":IlluminateToggleBuf<CR>", desc = "Toggle illuminate" },
    },
  },
}
