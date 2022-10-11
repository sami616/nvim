local key_mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(
        mode,
        key,
        result,
        {noremap = true, silent = true}
    )
end

key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('i', 'jk', '<ESC>')
key_mapper('i', 'JK', '<ESC>')
key_mapper('i', 'jK', '<ESC>')
key_mapper('v', 'jk', '<ESC>')
key_mapper('v', 'JK', '<ESC>')
key_mapper('v', 'jK', '<ESC>')
key_mapper('n', '<C-p>', ':Telescope find_files<cr>')
key_mapper('n', '<leader> ', ':Telescope file_browser<cr>')
key_mapper('n', '<leader>c', ':Telescope neoclip<cr>')
key_mapper('n', '<leader>p', ':lua vim.lsp.buf.formatting_sync()<cr>')
key_mapper('n', '<ESC>', ':noh<cr>')

-- Handles moving lines
key_mapper('n', '<C-j>', ':m .+1<CR>==')
key_mapper('n', '<C-k>', ':m .-2<CR>==')
key_mapper('i', '<C-j>', '<ESC>:m .+1<CR>==gi')
key_mapper('i', '<C-k>', '<ESC>:m .-2<CR>==gi')
key_mapper('v', '<C-j>', ':m \'>+1<CR>gv=gv')
key_mapper('v', '<C-k>', ':m \'<-2<CR>gv=gv')
