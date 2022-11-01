require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.comment"
require "user.lualine"
require "user.toggleterm"
require "user.indentline"
require "user.autocommands"
require "user.prettyfold"
require "user.signify"
require "user.alternate"
require "user.mundo"

if vim.g.neovide then
    require "user.neovide"
end

require "user.nvimqt"
