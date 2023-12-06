return {
	'dmmulroy/tsc.nvim',
	config = function()
		require('tsc').setup({
			flags = {
				-- build set to true ensures that an entire monorepo is scanned for errors, not just the package you're in.
				build = true,
			},
		})
	end,
}
