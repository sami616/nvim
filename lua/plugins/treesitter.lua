return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	keys = {
		{ '<c-space>', desc = 'Increment selection' },
		{ '<bs>', desc = 'Decrement selection', mode = 'x' },
	},
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				'bash',
				'html',
				'javascript',
				'json',
				'lua',
				'luadoc',
				'luap',
				'astro',
				'markdown',
				'markdown_inline',
				'yaml',
				'graphql',
				'regex',
				'tsx',
				'typescript',
				'astro',
				'vim',
				'vimdoc',
				'yaml',
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			enable = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<C-space>',
					node_incremental = '<C-space>',
					scope_incremental = false,
					node_decremental = '<bs>',
				},
			},
		})
	end,
}
