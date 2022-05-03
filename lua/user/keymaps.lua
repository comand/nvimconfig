local opts = {noremap = true, silent = true}

-- Remap comma as leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require'legendary'.bind_keymaps {
  -- Basic
  { 'QQ',  'ZQ', opts=opts },
  { 'Y',   'y$', opts=opts }, -- Make Y behave like D and C rather than dd and cc instead of yy

  -- Toggles
  { '<Tab>l', ':set invlist list?<CR>', opts=opts,
    description = 'Toggle list',
  },
  { '<Tab>n', ':set invnumber number?<CR>', opts=opts,
    description = 'Toggle number',
  },
  { '<Tab>p', ':set invpaste paste?<CR>', opts=opts,
    description = 'Toggle paste',
  },
  { '<Tab>h', ':set invhlsearch hlsearch?<CR>', opts=opts,
    description = 'Toggle hlsearch',
  },

  -- Buffers
  { '<C-n>', ':bnext<CR>', opts=opts,
    description = 'Next buffer',
  },
  { '<C-p>', ':bprevious<CR>', opts=opts,
    description = 'Previous buffer',
  },
  { '<Leader>w', ':bdelete<CR>', opts=opts,
    description = 'Close current buffer',
  },

  -- Windows
  { '<C-h>', '<C-w>h', opts=opts,
    description = 'Navigate to window at left',
  },
  { '<C-j>', '<C-w>j', opts=opts,
    description = 'Navigate to window below',
  },
  { '<C-k>', '<C-w>k', opts=opts,
    description = 'Navigate to window above',
  },
  { '<C-l>', '<C-w>l', opts=opts,
    description = 'Navigate to window at right',
  },

  -- Text
  { '<A-k>',
    {
      n = '<Esc>:move .-2<CR>==gi',
      v = ':move .-2<CR>==',
      x = ":move '<-2<CR>gv-gv",
    },
    opts = opts,
    description = 'Move selected line(s) up',
  },
  { '<A-j>',
    {
      n = '<Esc>:move .+1<CR>==gi',
      v = ':move .+1<CR>==',
      x = ":move '>+1<CR>gv-gv",
    },
    opts = opts,
    description = 'Move selected line(s) down',
  },

  { "K", { x = ":move '<-2<CR>gv-gv" }, opts=opts,
    description = 'Move visual block selection up',
  },
  { "J", { x = ":move '>+1<CR>gv-gv" }, opts=opts,
    description = 'Move visual block selection down',
  },

  { "<", { v = "<gv" }, opts=opts,
    description = 'Decrease indent',
  },
  { ">", { v = ">gv" }, opts=opts,
    description = 'Increase indent',
  },

  { "p", { v = '"_dP'}, opts=opts,
    description = 'Paste over visual selection',
  },

  { '<C-s>', ':%s/<C-R><C-W>/', opts=opts,
    description = 'Search and replace word under cursor',
  },

  -- Misc
  { '<Leader>cd', ':cd %:p:h<CR>:pwd<CR>', opts=opts,
    description = 'Change directory to current buffer',
  },
  { '<Leader>m', ':make<CR>', opts=opts,
    description = 'Build in current directory',
  },

  -- Qt Docs
  { '<Leader>qt', ':call QtDoc(expand("<cword>"))<CR>', opts=opts,
    description = 'Open Qt docs for word under cursor',
  },

  -- Perforce
  { '<Leader>pe', '<cmd>Vp4Edit<CR>', opts=opts,
    description = 'Vp4: open current file for edit',
  },
  { '<Leader>pr', '<cmd>Vp4Revert<CR>', opts=opts,
    description = 'Vp4: revert current file',
  },
  { '<Leader>pd', '<cmd>Vp4Diff<CR>', opts=opts,
    description = 'Vp4: diff current file',
  },
  { '<Leader>pi', '<cmd>Vp4Info<CR>', opts=opts,
    description = 'Vp4: display info for current file',
  },
  { '<Leader>ph', '<cmd>Vp4Filelog<CR>', opts=opts,
    description = 'Vp4: display history for current file',
  },

  -- Toggle Term
  { '<Leader>TG', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts=opts,
    description = 'Open lazygit',
  },
  { '<Leader>TD', '<cmd>lua _NCDU_TOGGLE()<CR>', opts=opts,
    description = 'Open ncdu',
  },
  { '<Leader>TT', '<cmd>lua _HTOP_TOGGLE()<CR>', opts=opts,
    description = 'Open htop',
  },
  { '<Leader>TP', '<cmd>lua _PYTHON_TOGGLE()<CR>', opts=opts,
    description = 'Open python terminal',
  },
  { '<Leader>TB', '<cmd>ToggleTerm size=10 direction=horizontal<CR>', opts=opts,
    description = 'Open terminal in bottom window',
  },

  -- Legendary
  { '<C-l>', '<cmd>Legendary<CR>', opts=opts,
    description = 'Legendary search',
  },
}
