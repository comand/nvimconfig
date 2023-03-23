return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  keys = {
    {
      '<Leader>TG',
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
        lazygit:toggle()
      end,
      noremap = true, silent = true, desc = "Open lazygit",
    },
    {
      '<Leader>TD',
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
        ncdu:toggle()
      end,
      noremap = true, silent = true, desc = 'Open ncdu'
    },
    {
      '<Leader>TT',
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local htop = Terminal:new({ cmd = "htop", hidden = true })
        htop:toggle()
      end,
      noremap = true, silent = true, desc = 'Open htop'
    },
    {
      '<Leader>TP',
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local python = Terminal:new({ cmd = "python", hidden = true })
        python:toggle()
      end,
      noremap = true, silent = true, desc = 'Open python terminal'
    },
    {
      '<Leader>TB',
      '<cmd>ToggleTerm size=10 direction=horizontal<CR>',
      noremap = true, silent = true, desc = 'Open terminal in bottom pane'
    },
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

    vim.api.nvim_create_autocmd("TermOpen", {
      group = vim.api.nvim_create_augroup("toggleterm", { clear = true }),
      pattern = "term://*",
      callback = function()
        local kopts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], kopts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], kopts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], kopts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], kopts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], kopts)
      end,
    })
  end,
}
