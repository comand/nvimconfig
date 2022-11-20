-- Add shortcuts
local legendary_ok, legendary = pcall(require, 'legendary')
if legendary_ok then
  local opts = {noremap = true, silent = true}
  legendary.keymaps {
    { '<Leader>ge', '<cmd>Gedit :<CR>', opts=opts,
      description = 'Fugitive: Gedit current buffer',
    },
  }
end
