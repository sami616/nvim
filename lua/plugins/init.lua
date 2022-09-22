local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    return false
  end
  
local packer_bootstrap = ensure_packer()

-- Use packer
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here
  use 'arcticicestudio/nord-vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'vim-airline/vim-airline'
  use 'kyazdani42/nvim-tree.lua'
  use 'tpope/vim-fugitive'
  use {'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)

  require('plugins/config')