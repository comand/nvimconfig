-- Add shortcuts
local legendary_ok, legendary = pcall(require, 'legendary')
if legendary_ok then
  local opts = {noremap = true, silent = true}
  legendary.bind_keymaps {
    { '<Leader>gd', ':call grok#DefinitionSearch()<CR>', opts=opts,
      description = 'Grok definition search word under cursor',
    },
    { '<Leader>gf', ':call grok#FullSearch()<CR>', opts=opts,
      description = 'Grok full search word under cursor',
    },
    { '<Leader>gs', ':call grok#SymbolSearch()<CR>', opts=opts,
      description = 'Grok symbol search word under cursor',
    },
    { '<Leader>gx', ':call grok#Xref()<CR>', opts=opts,
      description = 'Grok cross reference current file/line',
    },
  }
end
