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
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

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
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-e>', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-g>', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>tm', [[<cmd>lua require('telescope.builtin').marks()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>tr', [[<cmd>lua require('telescope.builtin').registers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>tk', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>th', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<Leader>tc', [[<cmd>lua require('telescope.builtin').commands()<CR>]], opts)
