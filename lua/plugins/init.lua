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
    -- LSP
	use 'neovim/nvim-lspconfig'
	-- CMP
    use 'hrsh7th/nvim-cmp' -- Auto complete
	use {
	  "AckslD/nvim-neoclip.lua",
  		requires = {
    		{'nvim-telescope/telescope.nvim'},
  		},
  		config = function()
     		require('neoclip').setup()
  		end
	}
    use'L3MON4D3/LuaSnip' -- Snippet engine
    use 'hrsh7th/cmp-buffer' -- Source for buffers
    use 'saadparwaiz1/cmp_luasnip' -- Source for snippet engine
	use 'hrsh7th/cmp-nvim-lsp' -- Source for lsp
	use 'onsails/lspkind-nvim' -- Nice formatting of auto complete popup
	-- Theme
	use 'folke/tokyonight.nvim'
	-- Misc
    use 'windwp/nvim-autopairs' 
	use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end } -- Syntax highlighting
	use 'nvim-treesitter/nvim-treesitter-context'
    use 'jose-elias-alvarez/null-ls.nvim' -- Formatting
    use { 'nvim-lualine/lualine.nvim',  requires ='kyazdani42/nvim-web-devicons' } -- Status bar
    use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' } -- Fuzzy find
	use { "nvim-telescope/telescope-file-browser.nvim" }
    use 'lukas-reineke/indent-blankline.nvim' -- Indent lines
    use 'windwp/nvim-ts-autotag' -- Auto tags
	 
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)

require('plugins/theme')
require('plugins/auto-tags')
require('plugins/line-indent')
require('plugins/auto-brackets')
require('plugins/lsp')
require('plugins/cmp')
require('plugins/null-ls')
require('plugins/telescope')
require('plugins/lualine')
require('plugins/treesitter')
require('plugins/treesitter-context')
