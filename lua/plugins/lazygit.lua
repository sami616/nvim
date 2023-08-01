return {
    'kdheepak/lazygit.nvim',
    keys = { { '<leader>g', desc = 'Git', mode = 'n' } },
    config = function()
        vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { desc = 'Git' })
    end,
}
