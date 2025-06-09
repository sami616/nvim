return {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = '▏', -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
			highlight = 'IndentBlankLineChar',
		},
		scope = {
			show_start = false,
			show_end = false,
		},
	},
	config = function(_, opts)
		require('ibl').setup(opts)
	end,
}
