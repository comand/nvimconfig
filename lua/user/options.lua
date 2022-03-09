local options = {
    backup = false,
    breakindent = true,
    clipboard = 'unnamedplus',
    cmdheight = 2,
    completeopt = {'menuone', 'noselect'},
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = 'utf-8',
    foldmethod = 'marker',
    hlsearch = false,
    ignorecase = true,
    mouse = 'a',
    pumheight = 10,
    showmode = false,
    showtabline = 1,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    termguicolors = true,
    timeoutlen = 100, -- time to wait for a mapped sequence to complete (ms)
    undofile = true,
    updatetime = 300, -- faster completion (4000ms default)
    writebackup = false,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    cursorline = false, -- highlight the current line
    signcolumn = "yes",
    scrolloff = 8,
    sidescrolloff = 8,
}

vim.opt.shortmess:append "c"
vim.opt.listchars:append('eol:↴')
vim.opt.listchars:append('space:⋅')

for k,v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.guifont = 'JetBrainsMono Nerd Font:h11'

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- vim.g['do_file_type_lua'] = 1
-- vim.g['did_load_filetypes'] = 0
