return {
    'kdheepak/lazygit.nvim',
    keys = { { '<leader>sc', desc = 'Git', mode = 'n' } },
    config = function()
        vim.keymap.set('n', '<leader>sc', ':LazyGit<CR>', { desc = '[S]ource [C]ontrol' })
    end,
}
