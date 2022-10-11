local status, plugin = pcall(require, "telescope")
if (not status) then return end

local actions = require "telescope.actions"

plugin.setup({
	pickers = {
	},
	extensions = {
		file_browser = {
			path = "%:p:h",
		}
	},
	 defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			}
		}
	}
})

require("telescope").load_extension "file_browser"
require("telescope").load_extension "neoclip"
