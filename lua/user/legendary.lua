local status_ok, legendary = pcall(require, 'legendary')
if status_ok then
  legendary.setup {
    keymaps = {
      {
        '<leader>gd',
        ':call grok#DefinitionSearch()<CR>',
        description = 'Grok definition search word under cursor',
        opts = { noremap = true, silent = true },
      },
      {
        '<leader>gf',
        ':call grok#FullSearch()<CR>',
        description = 'Grok full search word under cursor',
        opts = { noremap = true, silent = true },
      },
      {
        '<leader>gs',
        ':call grok#SymbolSearch()<CR>',
        description = 'Grok symbol search word under cursor',
        opts = { noremap = true, silent = true },
      },
      {
        '<leader>gx',
        ':call grok#Xref()<CR>',
        description = 'Grok cross reference current file/line',
        opts = { noremap = true, silent = true },
      },
    },
  }
end 

