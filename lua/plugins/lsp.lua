-- return {
-- 	-- official helpers for setting up installed language servers
-- 	'neovim/nvim-lspconfig',
-- 	dependencies = {
-- 		-- nice UI for installing language servers
-- 		{
-- 			'mason-org/mason.nvim',
-- 			dependencies = {
-- 				-- Automatically sets up any languages installed by mason
-- 				{
-- 					'mason-org/mason-lspconfig.nvim',
--
-- 					config = function()
-- 						require('mason').setup({})
-- 						local masonlsp = require('mason-lspconfig')
--
-- 						masonlsp.setup({
-- 							automatic_enable = false,
-- 							ensure_installed = {
-- 								'rust_analyzer',
-- 								'ts_ls',
-- 								'tailwindcss',
-- 								'cssls',
-- 								'html',
-- 								'astro',
-- 								'jsonls',
-- 								'yamlls',
-- 								'lua_ls',
-- 							},
-- 						})
--
-- 						local lspconfig = require('lspconfig')
--
-- 						local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
--
-- 						masonlsp.setup_handlers({
-- 							function(server_name)
-- 								local opts = { capabilities = lsp_capabilities }
-- 								lspconfig[server_name].setup(opts)
-- 							end,
-- 						})
--
-- 						vim.api.nvim_create_autocmd('LspAttach', {
-- 							desc = 'LSP actions',
-- 							callback = function(args)
-- 								-- require('workspace-diagnostics').populate_workspace_diagnostics(args.client, args.buf)
--
-- 								vim.keymap.set('n', '<leader>si', function()
-- 									vim.lsp.buf.execute_command({
-- 										command = '_typescript.organizeImports',
-- 										arguments = { vim.api.nvim_buf_get_name(0) },
-- 									})
-- 								end, { desc = '[S]ort [I]mports', buffer = args.buf })
-- 							end,
-- 						})
-- 					end,
-- 				},
-- 			},
-- 		},
-- 		-- autocompletion engine
-- 		{
-- 			'hrsh7th/nvim-cmp',
-- 			config = function()
-- 				local cmp = require('cmp')
-- 				cmp.setup({
-- 					window = {
-- 						completion = cmp.config.window.bordered({ border = 'rounded' }),
-- 						documentation = cmp.config.window.bordered({ border = 'rounded' }),
-- 					},
-- 					snippet = {
-- 						expand = function(args)
-- 							require('luasnip').lsp_expand(args.body)
-- 						end,
-- 					},
-- 					mapping = cmp.mapping.preset.insert({
-- 						['<C-u>'] = cmp.mapping.scroll_docs(-4),
-- 						['<C-d>'] = cmp.mapping.scroll_docs(4),
-- 						['<C-p>'] = cmp.mapping.select_prev_item(),
-- 						['<C-n>'] = cmp.mapping.select_next_item(),
-- 						['<C-Space>'] = cmp.mapping.complete(),
-- 						['<C-e>'] = cmp.mapping.abort(),
-- 						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 					}),
-- 					sources = {
-- 						{ name = 'nvim_lsp' },
-- 						{ name = 'path' },
-- 						{ name = 'luasnip' },
-- 						{ name = 'buffer' },
-- 					},
-- 				})
-- 			end,
-- 		},
-- 		-- makes lsp suggestions show up in autocomplete
-- 		{ 'hrsh7th/cmp-nvim-lsp' },
-- 		-- makes other words found in the same buffer show up in autocomplete
-- 		{ 'hrsh7th/cmp-buffer' },
-- 		-- makes path information (like imports) show up in autocomplete
-- 		{ 'hrsh7th/cmp-path' },
-- 		-- makes luasnip's show up in autocomplete
-- 		{
-- 			'saadparwaiz1/cmp_luasnip',
-- 			-- snippet engine
-- 			dependencies = {
-- 				'L3MON4D3/LuaSnip',
-- 				config = function()
-- 					local ls = require('luasnip')
-- 					require('luasnip.loaders.from_vscode').lazy_load()
--
-- 					vim.keymap.set({ 'i' }, '<C-k>', function()
-- 						ls.expand()
-- 					end, { silent = true, desc = 'Expand snippet' })
-- 					vim.keymap.set({ 'i', 's' }, '<C-l>', function()
-- 						ls.jump(1)
-- 					end, { silent = true, desc = 'Next snippet placeholder' })
-- 					vim.keymap.set({ 'i', 's' }, '<C-h>', function()
-- 						ls.jump(-1)
-- 					end, { silent = true, desc = 'Prev snippet placeholder' })
-- 				end,
-- 				-- a collection of common useful vs-code like snippets that work with luasnip
-- 				dependencies = { 'rafamadriz/friendly-snippets' },
-- 			},
-- 		},
-- 	},
-- 	config = function()
-- 		vim.api.nvim_create_autocmd('LspAttach', {
-- 			desc = 'LSP actions',
-- 			callback = function(args)
-- 				vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover', buffer = args.buf })
-- 				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [D]efinition', buffer = args.buf })
-- 				vim.keymap.set('n', 'gh', vim.diagnostic.open_float, { desc = '[O]pen [D]iagnostics', buffer = args.buf })
-- 				vim.keymap.set('n', '<leader>nd', vim.diagnostic.goto_next, { desc = '[N]ext [D]iagnostic', buffer = args.buf })
-- 				vim.keymap.set('n', '<leader>pd', vim.diagnostic.goto_prev, { desc = '[P]rev [D]iagnostic', buffer = args.buf })
-- 				vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = '[G]o to [T]ype definition', buffer = args.buf })
-- 				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]ename', buffer = args.buf })
-- 				vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = '[F]ormat', buffer = args.buf })
-- 				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', buffer = args.buf })
-- 			end,
-- 		})
-- 	end,
-- }
return {
	{
		'neovim/nvim-lspconfig',
	},
	{
		'mason-org/mason.nvim',
		opts = {},
	},
	{
		'mason-org/mason-lspconfig.nvim',
		dependencies = {
			'neovim/nvim-lspconfig',
			'mason-org/mason.nvim',
		},
		opts = {
			ensure_installed = {
				'rust_analyzer',
				'ts_ls',
				'tailwindcss',
				'cssls',
				'html',
				'astro',
				'jsonls',
				'yamlls',
				'lua_ls',
			},
		},
	},
}
