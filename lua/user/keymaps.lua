local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

-- Remap comma as leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

--
-- Normal Mode
--

-- Have Y behave like D and C rather than dd and cc (which is already done by yy)
keymap("n", "Y", "y$", opts)

-- Toggle list on/off
keymap("n", "\tl", ":set invlist list?<CR>", opts)
keymap("n", "<F2>", "\tl", {})

-- Toggle number on/off, normal and insert modes
keymap("n", "\tn", ":set invnumber number?<CR>", opts)
keymap("n", "<F3>", "\tn", {})
keymap("i", "<F3>", "<C-O>\tn", {})

-- Toggle paste on/off, normal and insert modes
keymap("n", "\tp", ":set invpaste paste?<CR>", opts)
keymap("n", "<F4>", "\tp", {})
keymap("i", "<F4>", "<C-O>\tp", {})
vim.o.pastetoggle = '<F4>'

-- Search and replace word under cursor
keymap("n", "<C-s>", ":%s/<C-R><C-W>/", opts)

-- Navigate buffers
keymap("n", "<C-n>", ":bnext<CR>", opts)
keymap("n", "<C-p>", ":bprevious<CR>", opts)

--
-- Insert Mode
--

--
-- Visual Mode
--

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

--
-- Visual Block Mode
--

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
