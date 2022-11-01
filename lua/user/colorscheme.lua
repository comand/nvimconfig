vim.o.background = 'light'

-- local status_ok, sol = pcall(require, 'solarized')
-- if status_ok then
--   vim.g.solarized_italic_strings = false
--   sol.set()
-- end

local status_ok, nightfox = pcall(require, 'nightfox')
if status_ok then
  vim.cmd('colorscheme dawnfox')
end

vim.cmd [[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]]
