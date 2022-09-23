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
    use {
      'neovim/nvim-lspconfig'
    }
    use {
      'arcticicestudio/nord-vim'
    }
    use {
      'hrsh7th/nvim-cmp'
    }
    use {
      'onsails/lspkind-nvim'
    }
    use {
      'lukas-reineke/indent-blankline.nvim'
    }
    use { 
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
    }
    use { 
      'glepnir/lspsaga.nvim',
      branch = 'main'
    }
    use {
      'L3MON4D3/LuaSnip'
    }
    use {
      'hrsh7th/cmp-nvim-lsp'
    }
    use {
      'hrsh7th/cmp-buffer'
    }
    use {
      'windwp/nvim-ts-autotag'
    }
    use {
      'windwp/nvim-autopairs'
    }
    use { 
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end
    }
    use {
      'jose-elias-alvarez/null-ls.nvim'
    }
    use {
      'MunifTanjim/prettier.nvim'
    }
    use { 
      'nvim-lualine/lualine.nvim', 
      requires ='kyazdani42/nvim-web-devicons'
    }
    use { 
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons'
    }
    use { 
      'nvim-telescope/telescope.nvim',
      requires = 'nvim-lua/plenary.nvim'
    }
      -- Automatically set up your configuration after cloning packer.nvim
      -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)

  require('plugins/config')
