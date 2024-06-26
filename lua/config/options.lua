vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 1
vim.opt.completeopt = {'menu', 'noselect', 'preview'}
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = false -- highlight the current line
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.foldlevelstart = 0
vim.opt.foldmethod = 'marker'
vim.opt.gdefault = true -- assume /g for :s
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.opt.grepprg = 'rg --vimgrep --no-heading'
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup_setpos'
vim.opt.pumheight = 10
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.textwidth = 78
vim.opt.undofile = true
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.wrap = false
vim.opt.writebackup = false

vim.opt.shortmess:append "cI"
vim.opt.whichwrap:append('<,>,[,],h,l')
vim.opt.iskeyword:append('-')

vim.opt.listchars:append {
  eol = '↴',
  space = '⋅',
  extends = '»',
  precedes = '«',
}

-- Turn off unnecessary providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Use a global nvim venv if it exists.
local venvdir = vim.fn.stdpath 'data' .. '/venv'
if vim.fn.executable(venvdir .. '/Scripts/python.exe') == 1 then
  vim.g.python3_host_prog = venvdir .. '/Scripts/python.exe'
elseif vim.fn.executable(venvdir .. '/bin/python') == 1 then
  vim.g.python3_host_prog = venvdir .. '/bin/python'
end
