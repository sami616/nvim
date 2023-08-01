return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.2',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		{ 'nvim-tree/nvim-web-devicons' },
	},
	config = function()
		require('telescope').load_extension('fzf')
		vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily find in buffer]' })
		vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find Recently opened' })
		vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers' })
		vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fl', require('telescope.builtin').resume, { desc = '[F]ind [L]last' })
		vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind [W]ord' })
		vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind [G]rep' })
		vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
		vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
		vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })
		vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = '[F]ind [S]ymbols (document)' })
		vim.keymap.set('n', '<leader>Fs', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[F]ind [S]ymbols (workspace)' })

		-- open telescope when running `nvim` inside a directory
		vim.api.nvim_create_autocmd('VimEnter', {
			callback = function()
				local argCount = vim.fn.argc()
				if argCount == 0 then
					require('telescope.builtin').find_files()
				elseif argCount == 1 then
					local stat = vim.loop.fs_stat(vim.fn.argv(0))
					if stat and stat.type == 'directory' then
						require('telescope.builtin').find_files()
					end
				end
			end,
		})
	end,
}
