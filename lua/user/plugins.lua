-- Packer Setup {{{
-- Install packer
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
--

-- Reload neovim when plugins.lua is saved
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]
--

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
-- }}}

return packer.startup(function(use)

  -- Basics
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use {'lewis6991/impatient.nvim',
    config = function()
      require'impatient'
      -- require'impatient'.enable_profile()
  end}
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Tree sitter
  use {'nvim-treesitter/nvim-treesitter', run=":TSUpdate"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- UI
  use 'stevearc/dressing.nvim'
  use 'rcarriga/nvim-notify'
  use 'EdenEast/nightfox.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use {'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'anuvyklack/fold-preview.nvim', requires = {
    'anuvyklack/nvim-keymap-amend',
    'anuvyklack/pretty-fold.nvim'
  }}
  use 'RRethy/vim-illuminate'
  use 'mrjones2014/legendary.nvim'

  -- Snippets
  use {'SirVer/UltiSnips',
    requires = { 'honza/vim-snippets', event = 'InsertEnter' }}
  use 'honza/vim-snippets'

  -- LSP
  use {'williamboman/mason.nvim',
       'williamboman/mason-lspconfig.nvim',
       'neovim/nvim-lspconfig'}
  --use 'tamago324/nlsp-settings.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'p00f/clangd_extensions.nvim'
  use {'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require'trouble'.setup()
  end}
  use {'j-hui/fidget.nvim',
    config = function()
      require'fidget'.setup()
  end}

  -- Completion
  use {'hrsh7th/nvim-cmp', requires = 'quangnguyen30192/cmp-nvim-ultisnips'}
  use {'quangnguyen30192/cmp-nvim-ultisnips', requires = 'SirVer/UltiSnips'}
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'

  -- SCM
  use 'tpope/vim-fugitive' -- Git commands in nvim

  -- Misc
  use 'numToStr/Comment.nvim'
  use 'akinsho/toggleterm.nvim'

  use 'simnalamburt/vim-mundo' -- undo viewer
  use 'tpope/vim-abolish' -- case sensitive search/replace
  use 'tpope/vim-eunuch'  -- file mode utilities
  use 'mhinz/vim-signify' -- hunk change markers for perforce
  use 'vim-scripts/a.vim' -- alternate between matching buffers
  use 'wsdjeg/vim-fetch'  -- handle file line numbers on input

  use 'ngemily/vim-vp4'   -- perforce file handling

  -- Local
  use '/pixar/ws/trees/comand/vim-perforce'
  use '/pixar/ws/trees/comand/vim-comand-pixar'
  use '/pixar/ws/trees/comand/grok-vim'

  if PACKER_BOOTSTRAP then
      require("packer").sync()
  end
end)
