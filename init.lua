-- Install package manager if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.ignorecase = true
vim.o.cursorline = true
vim.o.smartcase = true
vim.o.nu = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.updatetime = 50
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Packages
require('lazy').setup({

	-- LSP
	{
		-- official helpers for setting up installed language servers
		'neovim/nvim-lspconfig',
		dependencies = {
			-- nice UI for installing language servers
			{ 'williamboman/mason.nvim' },
			-- automatically sets up any languages installed by mason
			{ 'williamboman/mason-lspconfig.nvim' },
			-- autocompletion engine
			{ 'hrsh7th/nvim-cmp' },
			-- makes lsp suggestions show up in autocomplete
			{ 'hrsh7th/cmp-nvim-lsp' },
			-- makes other words found in the same buffer show up in autocomplete
			{ 'hrsh7th/cmp-buffer' },
			-- makes path information (like imports) show up in autocomplete
			{ 'hrsh7th/cmp-path' },
			-- makes luasnip's show up in autocomplete
			{
				'saadparwaiz1/cmp_luasnip',
				-- snippet engine
				dependencies = {
					'L3MON4D3/LuaSnip',
					-- a collection of common useful vs-code like snippets that work with luasnip
					dependencies = { 'rafamadriz/friendly-snippets' },
				},
			},
		},
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-Space>'] = cmp.mapping.complete(),
					['<Esc>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'path' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
				},
			})

			local ls = require('luasnip')

			require('luasnip.loaders.from_vscode').lazy_load()

			vim.keymap.set({ 'i' }, '<C-k>', function()
				ls.expand()
			end, { silent = true, desc = 'Expand snippet' })
			vim.keymap.set({ 'i', 's' }, '<C-l>', function()
				ls.jump(1)
			end, { silent = true, desc = 'Next snippet placeholder' })
			vim.keymap.set({ 'i', 's' }, '<C-h>', function()
				ls.jump(-1)
			end, { silent = true, desc = 'Prev snippet placeholder' })

			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(args)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover', buffer = args.buf })
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [D]efinition', buffer = args.buf })
					vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = '[G]o to [T]ype definition', buffer = args.buf })
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]ename', buffer = args.buf })
					vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = '[F]ormat', buffer = args.buf })
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', buffer = args.buf })
				end,
			})

			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {
					'rust_analyzer',
					'tsserver',
					'tailwindcss',
					'cssls',
					'html',
					'astro',
					'jsonls',
					'yamlls',
					'lua_ls',
				},
			})

			local lspconfig = require('lspconfig')
			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

			require('mason-lspconfig').setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			})
		end,
	},

	-- Include custom formatting (stylua/prettier)
	{
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local null_ls = require('null-ls')
			local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
			null_ls.setup({
				-- use prettier and sylua for formatting
				sources = { null_ls.builtins.formatting.stylua, null_ls.builtins.formatting.prettier },
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
	},

	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		keys = {
			{ '<c-space>', desc = 'Increment selection' },
			{ '<bs>', desc = 'Decrement selection', mode = 'x' },
		},
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					'bash',
					'html',
					'javascript',
					'json',
					'lua',
					'luadoc',
					'luap',
					'astro',
					'markdown',
					'markdown_inline',
					'yaml',
					'graphql',
					'regex',
					'tsx',
					'typescript',
					'astro',
					'vim',
					'vimdoc',
					'yaml',
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				enable = true,
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<C-space>',
						node_incremental = '<C-space>',
						scope_incremental = false,
						node_decremental = '<bs>',
					},
				},
			})
		end,
	},

	-- Tabs for buffers
	{ 'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons', config = {} },

	-- Auto bracket pairs
	{ 'windwp/nvim-autopairs', config = {} },

	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{ '<leader>e', desc = '[E]xplorer' },
		},
		config = function()
			require('neo-tree').setup({ window = { position = 'right' }, close_if_last_window = true })
			vim.keymap.set('n', '<leader>e', ':Neotree reveal toggle<CR>', { desc = '[E]xplorer' })
		end,
	},
	-- Auto tag closing
	{ 'windwp/nvim-ts-autotag', config = {} },

	-- Git
	{
		'kdheepak/lazygit.nvim',
		keys = { { '<leader>g', desc = 'Git', mode = 'n' } },
		config = function()
			vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { desc = 'Git' })
		end,
	},

	-- Theme
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme('tokyonight-night')
		end,
	},

	-- Status line
	{
		'nvim-lualine/lualine.nvim',
		priority = 999,
		dependencies = {
			{ 'nvim-tree/nvim-web-devicons' },
		},
		config = {},
	},

	-- Indent lines
	{
		'lukas-reineke/indent-blankline.nvim',
		config = { show_current_context = true },
	},

	-- LSP status indicator
	{ 'j-hui/fidget.nvim', config = {} },

	-- Git status signs
	{ 'lewis6991/gitsigns.nvim', config = {} },

	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-tree/nvim-web-devicons' },
		},
		-- open telescope when running `nvim` inside a directory
		init = function()
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
		config = function()
			require('telescope').setup({ extensions = { file_browser = { path = '%:p:h' } } })
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
		end,
	},

	-- Comments
	{ 'numToStr/Comment.nvim', config = {} },
})

----------------------------
-- General keymaps
----------------------------

vim.keymap.set('n', '<leader>s', ':w<CR>', { desc = '[S]ave file' })
vim.keymap.set('n', '<leader>t', '<C-^>', { desc = '[T]oggle last file' })
vim.keymap.set('n', '<leader>w', ':bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close current split' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move current selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move current selection up' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cursor in the same position when moving a line up' })
vim.keymap.set('n', '<C-o', '<C-o>zz', { desc = 'Center cursor when going back in jump list' })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { desc = 'Center cursor when going forwards in jump list' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor when moving up the page' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor when moving down the page' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Center curosr when moving to next search result' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Center curosr when moving to previous search result' })
vim.keymap.set('x', '<leader>p', [["_dp]], { desc = 'Paste over selection without losing current register' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to void register' })
vim.keymap.set('n', '<S-h>', ':bprev<CR>', { desc = 'Switch to prev buffers' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Switch to next buffers' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move left to split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move right to split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move down to split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move up to split' })
vim.keymap.set('n', '<leader>os', '<C-w>v <CR> <C-w>l', { desc = '[O]pen [S]plit' })

----------------------------
-- Misc
----------------------------

-- Highlight Yanks
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})
