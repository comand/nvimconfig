return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },

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
        },
      }

      telescope.load_extension("fzf")
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<C-b>', builtin.buffers,
        { noremap = true, silent = true, desc = 'Telescope: buffers' })
      vim.keymap.set('n', '<C-e>', function() builtin.find_files({ previewer = false }) end,
        { noremap = true, silent = true, desc = 'Telescope: find files' })
      vim.keymap.set('n', '<C-g>', builtin.live_grep,
        { noremap = true, silent = true, desc = 'Telescope: live grep' })
      vim.keymap.set('n', '<Leader>ft', builtin.grep_string,
        { noremap = true, silent = true, desc = 'Telescope: find term' })
      vim.keymap.set('n', '<Leader>tm', builtin.marks,
        { noremap = true, silent = true, desc = 'Telescope: marks' })
      vim.keymap.set('n', '<Leader>tr', builtin.registers,
        { noremap = true, silent = true, desc = 'Telescope: registers' })
      vim.keymap.set('n', '<Leader>tc', builtin.commands,
        { noremap = true, silent = true, desc = 'Telescope: commands' })
      vim.keymap.set('n', '<Leader>th', builtin.help_tags,
        { noremap = true, silent = true, desc = 'Telescope: help tags' })
      vim.keymap.set('n', '<Leader>tk', builtin.keymaps,
        { noremap = true, silent = true, desc = 'Telescope: keymaps' })
      vim.keymap.set('n', '<Leader>tl', function() builtin.live_grep({ grep_open_files = true }) end,
        { noremap = true, silent = true, desc = 'Telescope: buffer lines' })
    end,
  },
}
