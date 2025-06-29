vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Write' })
vim.keymap.set('v', '<C-J>', ":m '>+1<CR>gv=gv", { desc = 'Move current selection down' })
vim.keymap.set('v', '<C-K>', ":m '<-2<CR>gv=gv", { desc = 'Move current selection up' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cursor in the same position when moving a line up' })
vim.keymap.set('n', '<C-o', '<C-o>zz', { desc = 'Center cursor when going back in jump list' })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { desc = 'Center cursor when going forwards in jump list' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor when moving up the page' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor when moving down the page' })
vim.keymap.set('n', '<Up>', '<C-u>zz', { desc = 'Move up the page, centering the cursor each time' })
vim.keymap.set('n', '<Down>', '<C-d>zz', { desc = 'Move down the page, centering the cursor each time' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Center cursor when moving to next search result' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Center cursor when moving to previous search result' })
vim.keymap.set('n', '<S-h>', ':bprev<CR>', { desc = 'Switch to prev buffers' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Switch to next buffers' })
vim.keymap.set('n', '<S-w>', ':bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>t', '<C-6>', { desc = 'Toggle last buffer' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move left to split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move right to split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move down to split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move up to split' })
vim.keymap.set('n', '<leader>os', '<C-w>v <CR> <C-w>l', { desc = '[O]pen [S]plit' })
-- This is due to me swapping ' with ; on my keyboard
vim.keymap.set('n', "'", ';', { noremap = true })
