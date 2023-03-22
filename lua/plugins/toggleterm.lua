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
    { mode = "t", "<Esc>", "<C-><C-n>", noremap = true },
    { mode = "t", "<C-h>", "<C-><C-n><C-W>h", noremap = true },
    { mode = "t", "<C-j>", "<C-><C-n><C-W>j", noremap = true },
    { mode = "t", "<C-k>", "<C-><C-n><C-W>k", noremap = true },
    { mode = "t", "<C-l>", "<C-><C-n><C-W>l", noremap = true },
    {
      "<Leader>TG",
      "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
      noremap = true,
      silent = true,
      desc = "Open lazygit",
    },
    { "<Leader>TD", "<cmd>lua _NCDU_TOGGLE()<CR>", noremap = true, silent = true, desc = "Open ncdu" },
    { "<Leader>TT", "<cmd>lua _HTOP_TOGGLE()<CR>", noremap = true, silent = true, desc = "Open htop" },
    {
      "<Leader>TP",
      "<cmd>lua _PYTHON_TOGGLE()<CR>",
      noremap = true,
      silent = true,
      desc = "Open python terminal",
    },
    {
      "<Leader>TB",
      "<cmd>ToggleTerm size=10 direction=horizontal<CR>",
      noremap = true,
      silent = true,
      desc = "Open terminal in bottom window",
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    vim.api.nvim_create_autocmd("TermOpen", {
      group = "toggleterm",
      pattern = "term://*",
      callback = function()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end,
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
    function _NCDU_TOGGLE()
      ncdu:toggle()
    end

    local htop = Terminal:new({ cmd = "htop", hidden = true })
    function _HTOP_TOGGLE()
      htop:toggle()
    end

    local python = Terminal:new({ cmd = "python", hidden = true })
    function _PYTHON_TOGGLE()
      python:toggle()
    end
  end,
}
