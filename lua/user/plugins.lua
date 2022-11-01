-- Install packer {{{
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer -- close and reopen neovim..."
  vim.cmd [[packadd packer.nvim]]
end
-- }}}

-- Reload neovim when plugins.lua is saved {{{
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- }}}

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window {{{
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
-- }}}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use {'lewis6991/impatient.nvim', config = function()
    require'impatient'.enable_profile()
  end}
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use {'nvim-treesitter/nvim-treesitter', run=":TSUpdate"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- UI
  use 'shaunsingh/solarized.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use {'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'anuvyklack/pretty-fold.nvim'

  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'tamago324/nlsp-settings.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'p00f/clangd_extensions.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'

  -- SCM
  use 'tpope/vim-fugitive' -- Git commands in nvim

  -- Misc
  use 'numToStr/Comment.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'folke/which-key.nvim'

  if PACKER_BOOTSTRAP then
      require("packer").sync()
  end
end)
