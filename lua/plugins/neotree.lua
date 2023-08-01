return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    keys = {
        { '<leader>e', desc = '[E]xplorer' },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('neo-tree').setup({ window = { position = 'right' }, close_if_last_window = true })
        vim.keymap.set('n', '<leader>e', ':Neotree reveal toggle<CR>', { desc = '[E]xplorer' })
    end,
}
