return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		{ 'nvim-tree/nvim-web-devicons' },
	},
	config = function()
		local telescope = require('telescope')
		telescope.load_extension('fzf')
		telescope.setup({
			defaults = {
				mappings = {
					n = {
						['<C-w>'] = require('telescope.actions').delete_buffer,
					},
					i = {
						['<C-w>'] = require('telescope.actions').delete_buffer,
					},
				},

				-- "tail" → Shows only the filename.
				-- "truncate" → Truncates the beginning of long paths.
				-- "shorten" → Collapses middle parts of the path (/a/b/c/d.lua → /a/…/d.lua).
				-- "smart" → Tries to intelligently display a mix of truncation and tail.
				path_display = { 'smart' },
			},
		})

		vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily find in buffer]' })
		vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find Recently opened' })
		vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find [B]uffers' })
		vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find [F]iles' })
		vim.keymap.set('n', '<leader>fl', require('telescope.builtin').resume, { desc = 'Find [L]last' })
		vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Find [W]ord' })
		vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Find [G]rep' })
		vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find [D]iagnostics' })
		vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Find [K]eymaps' })
		vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = 'Find [R]eferences' })
		vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = 'Find Symbols (workspace)' })

		vim.keymap.set('n', '<leader>fc', function()
			require('telescope.builtin').find_files({
				cwd = vim.fn.stdpath('config'),
			})
		end, { desc = 'Find Config File' })

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
