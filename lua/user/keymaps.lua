local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

-- Remap comma as leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

--
-- Normal Mode
--

-- Map QQ to ZQ
keymap("n", "QQ", "ZQ", opts)
-- Have Y behave like D and C rather than dd and cc (which is already done by yy)
keymap("n", "Y", "y$", opts)

-- Toggle list on/off
keymap("n", "\tl", ":set invlist list?<CR>", opts)
-- keymap("n", "<F2>", "\tl", {})

-- Toggle number on/off, normal and insert modes
keymap("n", "\tn", ":set invnumber number?<CR>", opts)
-- keymap("n", "<F3>", "\tn", {})
-- keymap("i", "<F3>", "<C-O>\tn", {})

-- Toggle paste on/off, normal and insert modes
keymap("n", "\tp", ":set invpaste paste?<CR>", opts)
-- keymap("n", "<F4>", "\tp", {})
-- keymap("i", "<F4>", "<C-O>\tp", {})
-- vim.o.pastetoggle = '<F4>'

-- Search and replace word under cursor
keymap("n", "<C-s>", ":%s/<C-R><C-W>/", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-k>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-n>", ":bnext<CR>", opts)
keymap("n", "<C-p>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Change directory to current buffer
keymap("n", "<Leader>cd", ":cd %:p:h<CR>:pwd<CR>", opts)

-- Close the current buffer
keymap("n", "<Leader>w", ":bdelete<CR>", opts)

-- Build
keymap("n", "<Leader>m", ":make<CR>", opts)


-- Qt Docs
keymap("n", "<Leader>qt", ':call QtDoc(expand("<cword>"))<CR>', opts)

-- Perforce
keymap("n", "<Leader>pe", "<cmd>Vp4Edit<CR>", opts)
keymap("n", "<Leader>pr", "<cmd>Vp4Revert<CR>", opts)
keymap("n", "<Leader>pd", "<cmd>Vp4Diff<CR>", opts)
keymap("n", "<Leader>pi", "<cmd>Vp4Info<CR>", opts)
keymap("n", "<Leader>pf", "<cmd>Vp4Filelog<CR>", opts)

-- Toggle Term
keymap("n", "<Leader>Tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<Leader>Td", "<cmd>lua _NCDU_TOGGLE()<CR>", opts)
keymap("n", "<Leader>Tt", "<cmd>lua _HTOP_TOGGLE()<CR>", opts)
keymap("n", "<Leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", opts)
keymap("n", "<C-t>", "<cmd>ToggleTerm direction=float<CR>", opts)

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
