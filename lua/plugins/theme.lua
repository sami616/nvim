return {
	'olivercederborg/poimandres.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('poimandres').setup({
			dim_nc_background = true, -- dim 'non-current' window backgrounds
			disable_italics = true, -- disable italics
			bold_vert_split = false, -- use bold vertical separators
			-- disable_background = true, -- disable background
			-- disable_float_background = true, -- disable background for floats
		})
	end,

	-- optionally set the colorscheme within lazy config
	init = function()
		vim.cmd('colorscheme poimandres')
	end,
}

-- return {
-- 	'folke/tokyonight.nvim',
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require('tokyonight').setup({
-- 			transparent = true,
-- 			styles = {
-- 				comments = { italic = false },
-- 				keywords = { italic = false },
-- 				sidebars = 'transparent',
-- 				floats = 'transparent',
-- 			},
-- 		})
-- 		vim.cmd.colorscheme('tokyonight-moon')
-- 	end,
-- }
