return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension("fzf")

      local actions = require('telescope.actions')

      telescope.setup {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          layout_strategy = 'vertical',
          layout_config = {
            height = vim.o.lines,
            width = vim.o.columns,
            preview_height = 0.6,
          },

          mappings = {
            i = {
              -- ["<C-n>"] = actions.cycle_history_next,
              -- ["<C-p>"] = actions.cycle_history_prev,

              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,

              ["<esc>"] = actions.close,
            },


            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
          },
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ['<C-w>'] = 'delete_buffer',
              },
            },
          },
        },
      }
    end,
    keys = {
      {
        '<C-b>', function() require('telescope.builtin').buffers { previewer = false } end,
        noremap = true, silent = true, desc = 'Telescope: buffers',
      },
      {
        '<C-e>', function() require('telescope.builtin').find_files() end,
        noremap = true, silent = true, desc = 'Telescope: find files',
      },
      {
        '<C-g>', function() require('telescope.builtin').live_grep() end,
        noremap = true, silent = true, desc = 'Telescope: live grep',
      },
      {
        '<Leader>ft', function() require('telescope.builtin').grep_string() end,
        noremap = true, silent = true, desc = 'Telescope: find term',
      },
      {
        '<Leader>tm', function() require('telescope.builtin').marks() end,
        noremap = true, silent = true, desc = 'Telescope: marks',
      },
      {
        '<Leader>tr', function() require('telescope.builtin').registers() end,
        noremap = true, silent = true, desc = 'Telescope: registers',
      },
      {
        '<Leader>tc', function() require('telescope.builtin').commands() end,
        noremap = true, silent = true, desc = 'Telescope: commands',
      },
      {
        '<Leader>th', function() require('telescope.builtin').help_tags() end,
        noremap = true, silent = true, desc = 'Telescope: help tags',
      },
      {
        '<Leader>tk', function() require('telescope.builtin').keymaps() end,
        noremap = true, silent = true, desc = 'Telescope: keymaps',
      },
      {
        '<Leader>tl', function() require('telescope.builtin').live_grep({ grep_open_files = true }) end,
        noremap = true, silent = true, desc = 'Telescope: buffer lines',
      },
    },
  },
}
