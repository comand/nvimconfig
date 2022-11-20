-- Add shortcuts
local legendary_ok, legendary = pcall(require, 'legendary')
if legendary_ok then
  local opts = {noremap = true, silent = true}
  legendary.keymaps {
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
  }
end
