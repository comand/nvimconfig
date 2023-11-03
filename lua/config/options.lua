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
vim.opt.lazyredraw = true
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup_setpos'
vim.opt.pumheight = 10
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
--vim.opt.showbreak = '↪'
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

vim.opt.shortmess:append "c"
vim.opt.listchars:append('eol:↴')
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('extends:»')
vim.opt.listchars:append('precedes:«')

vim.g.loaded_perl_provider = 0

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
