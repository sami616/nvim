return {
	'stevearc/conform.nvim',
	opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			javascript = { 'prettier' },
			typescript = { 'prettier' },
			typescriptreact = { 'prettier' },
			css = { 'prettier' },
			html = { 'prettier' },
			json = { 'prettier' },
			yaml = { 'prettier' },
			markdown = { 'prettier' },
			graphql = { 'prettier' },
			md = { 'prettier' },
			txt = { 'prettier' },
			astro = { 'prettier' },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = 'fallback',
		},
	},
}
