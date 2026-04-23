return {
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim', branch = 'master' },
		},
		build = 'make tiktoken',
		opts = {
			temperature = 0.1, -- Lower = focused, higher = creative
			window = {
				title = '🤖 AI Assistant',
				layout = 'vertical', -- 'vertical', 'horizontal', 'float'
				width = 0.4, -- 50% of screen width
			},
			headers = {
				user = '👤 You',
				assistant = '🤖 Copilot',
				tool = '🔧 Tool',
			},
			separator = '━━',
			auto_fold = true, -- Automatically folds non-assistant messages
			auto_insert_mode = false, -- Enter insert mode when opening
			-- See Configuration section for options
			mappings = {
				reset = {
					normal = '',
				},
				complete = {
					insert = '<C-o>',
				},
				close = {
					normal = '',
					insert = '',
				},
			},
		},
		config = function(_, opts)
			require('CopilotChat').setup(opts)
			vim.keymap.set('n', '<leader>cc', ':CopilotChatToggle<cr>', { desc = '[C]opilot [C]hat' })
		end,
	},
}
