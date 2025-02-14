local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, {noremap = true, silent = true, desc = desc})
end

-- Toggles
nmap('<Tab>l', ':set invlist list?<CR>', 'Toggle list chars')
nmap('<Tab>n', ':set invnumber number?<CR>', 'Toggle line numbers')
nmap('<Tab>h', ':set invhlsearch hlsearch?<CR>', 'Toggle search highlight')
nmap('<Tab>s', ':set invspell spell?<CR>', 'Toggle spell check')
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

nmap("<leader>l", "<cmd>Lazy<cr>", "Lazy")

--- vim-unimpaired style mappings. See: https://github.com/tpope/vim-unimpaired
--- Remove when 0.11 is released.
do
  --- Execute a command and print errors without a stacktrace.
  --- @param opts table Arguments to |nvim_cmd()|
  local function cmd(opts)
    local ok, err = pcall(vim.api.nvim_cmd, opts, {})
    if not ok then
      vim.api.nvim_err_writeln(err:sub(#'Vim:' + 1))
    end
  end

  -- Quickfix mappings
  vim.keymap.set('n', '[q', function()
    cmd({ cmd = 'cprevious', count = vim.v.count1 })
  end, { desc = ':cprevious' })

  vim.keymap.set('n', ']q', function()
    cmd({ cmd = 'cnext', count = vim.v.count1 })
  end, { desc = ':cnext' })

  vim.keymap.set('n', '[Q', function()
    cmd({ cmd = 'crewind', count = vim.v.count ~= 0 and vim.v.count or nil })
  end, { desc = ':crewind' })

  vim.keymap.set('n', ']Q', function()
    cmd({ cmd = 'clast', count = vim.v.count ~= 0 and vim.v.count or nil })
  end, { desc = ':clast' })

  vim.keymap.set('n', '[<C-Q>', function()
    cmd({ cmd = 'cpfile', count = vim.v.count1 })
  end, { desc = ':cpfile' })

  vim.keymap.set('n', ']<C-Q>', function()
    cmd({ cmd = 'cnfile', count = vim.v.count1 })
  end, { desc = ':cnfile' })

  -- Location list mappings
  vim.keymap.set('n', '[l', function()
    cmd({ cmd = 'lprevious', count = vim.v.count1 })
  end, { desc = ':lprevious' })

  vim.keymap.set('n', ']l', function()
    cmd({ cmd = 'lnext', count = vim.v.count1 })
  end, { desc = ':lnext' })

  vim.keymap.set('n', '[L', function()
    cmd({ cmd = 'lrewind', count = vim.v.count ~= 0 and vim.v.count or nil })
  end, { desc = ':lrewind' })

  vim.keymap.set('n', ']L', function()
    cmd({ cmd = 'llast', count = vim.v.count ~= 0 and vim.v.count or nil })
  end, { desc = ':llast' })

  vim.keymap.set('n', '[<C-L>', function()
    cmd({ cmd = 'lpfile', count = vim.v.count1 })
  end, { desc = ':lpfile' })

  vim.keymap.set('n', ']<C-L>', function()
    cmd({ cmd = 'lnfile', count = vim.v.count1 })
  end, { desc = ':lnfile' })

  -- Argument list
  vim.keymap.set('n', '[a', function()
    cmd({ cmd = 'previous', count = vim.v.count1 })
  end, { desc = ':previous' })

  vim.keymap.set('n', ']a', function()
    -- count doesn't work with :next, must use range. See #30641.
    cmd({ cmd = 'next', range = { vim.v.count1 } })
  end, { desc = ':next' })

  vim.keymap.set('n', '[A', function()
    if vim.v.count ~= 0 then
      cmd({ cmd = 'argument', count = vim.v.count })
    else
      cmd({ cmd = 'rewind' })
    end
  end, { desc = ':rewind' })

  vim.keymap.set('n', ']A', function()
    if vim.v.count ~= 0 then
      cmd({ cmd = 'argument', count = vim.v.count })
    else
      cmd({ cmd = 'last' })
    end
  end, { desc = ':last' })

  -- Tags
  vim.keymap.set('n', '[t', function()
    -- count doesn't work with :tprevious, must use range. See #30641.
    cmd({ cmd = 'tprevious', range = { vim.v.count1 } })
  end, { desc = ':tprevious' })

  vim.keymap.set('n', ']t', function()
    -- count doesn't work with :tnext, must use range. See #30641.
    cmd({ cmd = 'tnext', range = { vim.v.count1 } })
  end, { desc = ':tnext' })

  vim.keymap.set('n', '[T', function()
    -- count doesn't work with :trewind, must use range. See #30641.
    cmd({ cmd = 'trewind', range = vim.v.count ~= 0 and { vim.v.count } or nil })
  end, { desc = ':trewind' })

  vim.keymap.set('n', ']T', function()
    -- :tlast does not accept a count, so use :trewind if count given
    if vim.v.count ~= 0 then
      cmd({ cmd = 'trewind', range = { vim.v.count } })
    else
      cmd({ cmd = 'tlast' })
    end
  end, { desc = ':tlast' })

  vim.keymap.set('n', '[<C-T>', function()
    -- count doesn't work with :ptprevious, must use range. See #30641.
    cmd({ cmd = 'ptprevious', range = { vim.v.count1 } })
  end, { desc = ' :ptprevious' })

  vim.keymap.set('n', ']<C-T>', function()
    -- count doesn't work with :ptnext, must use range. See #30641.
    cmd({ cmd = 'ptnext', range = { vim.v.count1 } })
  end, { desc = ':ptnext' })

  -- Buffers
  vim.keymap.set('n', '[b', function()
    cmd({ cmd = 'bprevious', count = vim.v.count1 })
  end, { desc = ':bprevious' })

  vim.keymap.set('n', ']b', function()
    cmd({ cmd = 'bnext', count = vim.v.count1 })
  end, { desc = ':bnext' })

  vim.keymap.set('n', '[B', function()
    if vim.v.count ~= 0 then
      cmd({ cmd = 'buffer', count = vim.v.count })
    else
      cmd({ cmd = 'brewind' })
    end
  end, { desc = ':brewind' })

  vim.keymap.set('n', ']B', function()
    if vim.v.count ~= 0 then
      cmd({ cmd = 'buffer', count = vim.v.count })
    else
      cmd({ cmd = 'blast' })
    end
  end, { desc = ':blast' })

  -- Add empty lines
  vim.keymap.set('n', '[<Space>', function()
    -- TODO: update once it is possible to assign a Lua function to options #25672
    vim.go.operatorfunc = "v:lua.require'vim._buf'.space_above"
    return 'g@l'
  end, { expr = true, desc = 'Add empty line above cursor' })

  vim.keymap.set('n', ']<Space>', function()
    -- TODO: update once it is possible to assign a Lua function to options #25672
    vim.go.operatorfunc = "v:lua.require'vim._buf'.space_below"
    return 'g@l'
  end, { expr = true, desc = 'Add empty line below cursor' })
end
