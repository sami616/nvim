return {
	'akinsho/bufferline.nvim',
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline').setup({})
		vim.keymap.set('n', '<leader>cr', ':BufferLineCloseRight<CR>', { desc = '[C]lose [R]ight' })
		vim.keymap.set('n', '<leader>cl', ':BufferLineCloseLeft<CR>', { desc = '[C]lose [L]eft' })
		vim.keymap.set('n', '<leader>co', ':BufferLineCloseOthers<CR>', { desc = '[C]lose [O]thers' })
	end,
}
