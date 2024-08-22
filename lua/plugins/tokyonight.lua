-- return {
--     'olivercederborg/poimandres.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('poimandres').setup({
--             -- leave this setup function empty for default config
--             -- or refer to the configuration section
--             -- for configuration options
--         })
--     end,
--
--     -- optionally set the colorscheme within lazy config
--     init = function()
--         vim.cmd('colorscheme poimandres')
--     end,
-- }
return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme('tokyonight-night')
    end,
}
