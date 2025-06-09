return {
	'nvim-lualine/lualine.nvim',
	priority = 999,
	dependencies = {
		{ 'nvim-tree/nvim-web-devicons' },
	},
	config = function()
		require('lualine').setup({
			sections = {
				lualine_c = { { 'filename', path = 1 } },
			},
			theme = 'poimandres',
		})
	end,
}
