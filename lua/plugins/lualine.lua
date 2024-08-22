return {
	'nvim-lualine/lualine.nvim',
	priority = 999,
	dependencies = {
		{ 'nvim-tree/nvim-web-devicons' },
	},
	config = {
		sections = {
			lualine_c = {
				{
					'filename',
					path = 1,
				},
			},
		},
	},
}
