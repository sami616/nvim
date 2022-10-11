--
-- Null-LS
--

local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = { formatting.prettier }
})

-- Auto format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

