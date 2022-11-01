vim.cmd [[
try
  colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
vim.o.background = 'light'
