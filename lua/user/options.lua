local options = {
    backup = false,
    breakindent = true,
    clipboard = 'unnamedplus',
    cmdheight = 0,
    completeopt = {'menuone', 'noselect'},
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = 'utf-8',
    foldmethod = 'marker',
    foldlevelstart = 0,
    hlsearch = false,
    ignorecase = true,
    lazyredraw = true,
    gdefault = true, -- assume /g for :s
    pumheight = 10,
    showmode = false,
    showtabline = 1,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    termguicolors = true,
    undofile = true,
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    shiftround = true,
    textwidth = 78,
    cursorline = false, -- highlight the current line
    signcolumn = "yes",
    scrolloff = 8,
    sidescrolloff = 8,
    --showbreak = '↪',
    wrap = false,
    grepprg = 'rg --vimgrep --no-heading',
    grepformat = '%f:%l:%c:%m,%f:%l:%m',
    mouse = 'a',
    mousemodel = 'popup_setpos',
}

vim.cmd [[vmap <LeftRelease> "*ygv]]

vim.opt.shortmess:append "c"
vim.opt.listchars:append('eol:↴')
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('extends:»')
vim.opt.listchars:append('precedes:«')

for k,v in pairs(options) do
    vim.opt[k] = v
end

vim.g.python3_host_prog = '/home/comand/.local/opt/pyenv/shims/python3'
vim.g.loaded_perl_provider = 0

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
