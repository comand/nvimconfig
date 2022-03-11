vim.g.signify_sign_add = '┃'
vim.g.signify_sign_delete = '┃'
vim.g.signify_sign_delete_first_line = '┃'
vim.g.signify_sign_change = '┃'
vim.g.signify_sign_show_count = false

vim.cmd [[
highlight SignifySignAdd    ctermfg=DarkGreen  guifg=#169135 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=DarkRed    guifg=#b02e3b cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=DarkYellow guifg=#c7c92c cterm=NONE gui=NONE
]]
