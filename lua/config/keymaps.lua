local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, {noremap = true, silent = true, desc = desc})
end

-- Toggles
nmap('<Tab>l', ':set invlist list?<CR>', 'Toggle list chars')
nmap('<Tab>n', ':set invnumber number?<CR>', 'Toggle line numbers')
nmap('<Tab>h', ':set invhlsearch hlsearch?<CR>', 'Toggle search highlight')
nmap('<Tab>o', function()
  local value = vim.api.nvim_get_option_value('colorcolumn', {})
  if value == '' then
    vim.api.nvim_set_option_value('colorcolumn', '80', {})
  else
    vim.api.nvim_set_option_value('colorcolumn', value, {})
  end
end, 'Toggle colorcolumn')

-- Buffer navigation
nmap('<C-n>', ':bnext<CR>', 'Next buffer')
nmap('<C-p>', ':bprevious<CR>', 'Previous buffer')
nmap('<Leader>w', ':bdelete<CR>', 'Close current buffer')

-- Window navigation
nmap('<C-h>', '<C-w>h', 'Navigate to window at left')
nmap('<C-j>', '<C-w>j', 'Navigate to window below')
nmap('<C-k>', '<C-w>k', 'Navigate to window above')
nmap('<C-l>', '<C-w>l', 'Navigate to window at right')

-- Text
vim.keymap.set('v', '<', '<gv', { desc = 'Decrease indent' })
vim.keymap.set('v', '>', '>gv', { desc = 'Increase indent' })
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste over visual selection'})

nmap('<C-s>', ':%s/<C-R><C-W>/', 'Search and replace word under cursor')

-- Misc
nmap('<Leader>cd', ':cd %:p:h<CR>:pwd<CR>', 'Change directory to current buffer')
nmap('<Leader>m', ':make<CR>', 'Build in current directory')
nmap('QQ', 'ZQ', 'Quick Quit')
--nmap('y', 'y$')

vim.keymap.set('v', '<LeftRelease>', '*ygv',
  { desc = 'Yank to clipboard on mouse release' })

nmap("<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

