--
-- Treesitter context
--

local status, plugin = pcall(require, "treesitter-context")
if (not status) then return end

plugin.setup({
	patterns = {
		default = {
			'try',
			'catch',
			'reduce',
			'createMemo',
			'useEffect',
			'class',
			'return',
			'function',
			'method',
			'for',
			'while',
			'if',
			'switch',
			'case',
		}
	}
})
