require("nvim-tree").setup({
    view = {
        mappings = {
          list = {
            { key = "l", action = "open" },
            { key = "h", action = "close_node" },
          },
        },
      }
})
require('telescope').setup({
    file_ignore_patterns = { "node_modules", "dist", "build", ".git" }
})
