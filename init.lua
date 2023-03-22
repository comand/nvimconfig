-- Set leader -- must happen before plugins are required.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Plugin Manager Preamble {{{
-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
-- }}}

require('lazy').setup {
  { -- Color Scheme
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      vim.o.background = 'light'
      vim.cmd.colorscheme 'dawnfox'
    end,
  },
  { import = 'plugins' },
  --{ import = 'plugins.site' },
}

require('config.options')
require('config.autocommands')
require('config.keymaps')
