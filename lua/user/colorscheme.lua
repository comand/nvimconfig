vim.cmd [[
set background=light
try
  colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
