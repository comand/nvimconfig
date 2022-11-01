local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

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
      find_command = {'fd', '--type', 'f', '--strip-cwd-prefix'},
    },
  },
}

telescope.load_extension('fzf')

-- Add shortcuts
local legendary_ok, legendary = pcall(require, 'legendary')
if legendary_ok then
  local opts = {noremap = true, silent = true}
  local builtin = require'telescope.builtin'
  legendary.bind_keymaps {
    {'<C-b>', builtin.buffers, opts=opts,
      description = 'Telescope: buffers'
    },
    {'<C-e>',
      function() builtin.find_files{previewer=false} end,
      opts=opts,
      description = 'Telescope: find files'
    },
    {'<C-g>', builtin.live_grep, opts=opts,
      description = 'Telescope: live grep'
    },
    {'<Leader>tl',
      function() builtin.live_grep({grep_open_files=true}) end,
      opts=opts,
      description = 'Telescope: buffer lines'
    },
    {'<Leader>tm', builtin.marks, opts=opts,
      description = 'Telescope: marks'
    },
    {'<Leader>tr', builtin.registers, opts=opts,
      description = 'Telescope: registers'
    },
    {'<Leader>tc', builtin.commands, opts=opts,
      description = 'Telescope: commands'
    },
    {'<Leader>th', builtin.help_tags, opts=opts,
      description = 'Telescope: help tags'
    },
    {'<Leader>tk', builtin.keymaps, opts=opts,
      description = 'Telescope: keymaps'
    },
  }
end
