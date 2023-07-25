-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
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


-- Packages
require('lazy').setup({

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            local lsp = require('lsp-zero').preset({})
            lsp.on_attach(function(_, bufnr)
                -- see :help lsp-zero-keybindings to learn the available actions
                lsp.default_keymaps({ buffer = bufnr })
            end)
            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            lsp.setup()
        end
    },

    -- Tabs for buffers
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', config = {} },

    -- Auto bracket pairs
    { 'windwp/nvim-autopairs',   config = {} },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", desc = "[E]xplorer" },
        },
        config = function()
            require('neo-tree').setup({
                window = {
                    position = 'right'
                }
            })
            vim.keymap.set('n', '<leader>e', ':Neotree toggle=true<CR>', { desc = "[E]xplorer"})
        end
    },
    -- Auto tag closing
    { 'windwp/nvim-ts-autotag',  config = {} },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        config = function()
            require 'nvim-treesitter.configs'.setup({
                ensure_installed = { "bash",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "luadoc",
                    "luap",
                    "astro",
                    "markdown",
                    "markdown_inline",
                    "yaml",
                    "graphql",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml" },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                enable = true,
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })
        end
    },

    -- Git
    {
        "kdheepak/lazygit.nvim",
        keys = { { "<leader>g", desc = "Git", mode = "n" } },
        config = function()
            vim.keymap.set('n', '<leader>g', ':LazyGit<CR>')
        end
    },

    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd.colorscheme('tokyonight-night') end
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        priority = 998,
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' }
        },
        config = {}
    },

    -- Indent lines
    {
        'lukas-reineke/indent-blankline.nvim',
        config = { show_current_context = true }
    },

    -- LSP status indicator
    { 'j-hui/fidget.nvim',       config = {} },

    -- Git status signs
    { 'lewis6991/gitsigns.nvim', config = {} },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
            { 'nvim-tree/nvim-web-devicons' }
        },
        config = function()
            require('telescope').setup({ extensions = { file_browser = { path = '%:p:h' } } })
            require('telescope').load_extension('fzf')
            vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
                { desc = '[/] Fuzzily find in buffer]' })
            vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[F]ind [R]ecent' })
            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [B]uffers' })
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
            vim.keymap.set('n', '<leader>fl', require('telescope.builtin').resume, { desc = '[F]ind [L]last' })
            vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind [W]ord' })
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind [G]rep' })
            vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
            vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = '[F]ind [K]eymaps' })
            vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references,
                { desc = '[F]ind [R]eferences' })
            vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols,
                { desc = '[F]ind [S]ymbols (document)' })
            vim.keymap.set('n', '<leader>Fs', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                { desc = '[F]ind [S]ymbols (workspace)' })
        end
    },

    -- Comments
    { 'numToStr/Comment.nvim', config = {} },

    -- Format on save with null-ls
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require('null-ls')
            local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
            local event = 'BufWritePre'
            local async = event == 'BufWritePost'
            null_ls.setup({
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.keymap.set('n', '<leader>f', function()
                            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                        end, { buffer = bufnr, desc = '[lsp] format' })
                        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                        vim.api.nvim_create_autocmd(event, {
                            buffer = bufnr,
                            group = group,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr, async = async })
                            end,
                            desc = '[lsp] format on save',
                        })
                    end

                    if client.supports_method('textDocument/rangeFormatting') then
                        vim.keymap.set('x', '<leader>f', function()
                            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                        end, { buffer = bufnr, desc = '[lsp] format' })
                    end
                end,
            })
        end
    },

    -- Prettier
    {
        'MunifTanjim/prettier.nvim',
        config = {
            cli_options = {
                arrow_parens = 'avoid',
                bracket_spacing = true,
                bracket_same_line = true,
                print_width = 100,
                semi = false,
                single_quote = true,
                tab_width = 2,
                trailing_comma = 'none',
                use_tabs = false,
            },
            bin = 'prettier',
            filetypes = { 'css', 'astro', 'graphql', 'html', 'javascript', 'javascriptreact', 'json', 'markdown',
                'typescript',
                'typescriptreact', 'yaml' },
        }
    },
})

----------------------------
-- General keymaps
----------------------------

vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "[S]ave file" })
vim.keymap.set('n', '<leader>t', '<C-^>', { desc = "[T]oggle last file" })
vim.keymap.set('n', '<leader>w', ':bd<CR>', { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close current split" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor in the same position when moving a line up" })
vim.keymap.set('n', '<C-o', '<C-o>zz', { desc = "Center cursor when going back in jump list" })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { desc = "Center cursor when going forwards in jump list" })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Center cursor when moving up the page" })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Center cursor when moving down the page" })
vim.keymap.set('n', 'n', 'nzz', { desc = "Center curosr when moving to next search result" })
vim.keymap.set('n', 'N', 'Nzz', { desc = "Center curosr when moving to previous search result" })
vim.keymap.set("x", "<leader>p", [["_dp]], { desc = "Paste over selection without losing current register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "Switch to prev buffers" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Switch to next buffers" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left to split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right to split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down to split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up to split" })
vim.keymap.set("n", "<leader>os", "<C-w>v <CR> <C-w>l", { desc = "[O]pen [S]plit" })

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
