return {
	'jose-elias-alvarez/null-ls.nvim',
	config = function()
		local null_ls = require('null-ls')
		local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
		null_ls.setup({
			-- use prettier and sylua for formatting
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						'javascript',
						'typescript',
						'typescriptreact',
						'css',
						'html',
						'json',
						'yaml',
						'markdown',
						'graphql',
						'md',
						'txt',
						'astro',
					},
				}),
			},
			-- format on save
			on_attach = function(client, bufnr)
				if client.supports_method('textDocument/formatting') then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd('BufWritePre', {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
