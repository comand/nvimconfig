-- Add shortcuts
local legendary_ok, legendary = pcall(require, 'legendary')
if legendary_ok then
  local opts = {noremap = true, silent = true}
  legendary.bind_keymaps {
    { '<Leader>xx', '<cmd>TroubleToggle<CR>', opts=opts,
      description = 'Trouble: toggle list',
    },
    { '<Leader>xr', '<cmd>TroubleRefresh<CR>', opts=opts,
      description = 'Trouble: refresh list',
    },
    { '<Leader>xw', '<cmd>Trouble workspace_diagnostics<CR>', opts=opts,
      description = 'Trouble: workspace diagnostics',
    },
    { '<Leader>xd', '<cmd>Trouble document_diagnostics<CR>', opts=opts,
      description = 'Trouble: document diagnostics',
    },
    { '<Leader>xl', '<cmd>Trouble loclist<CR>', opts=opts,
      description = 'Trouble: location list',
    },
    { '<Leader>xq', '<cmd>Trouble quickfix<CR>', opts=opts,
      description = 'Trouble: quick fix',
    },
    { 'gR', '<cmd>Trouble lsp_references<CR>', opts=opts,
      description = 'Trouble: LSP references',
    },
  }
end
