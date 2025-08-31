local M = {}

M.opts = {
	defaults = {
		find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden" },
		file_ignore_patterns = {
			"%.git/objects/",
			"%.git/logs/",
			"node_modules/",
			"%.log$",
		},
	},
	pickers = {
		find_files = { hidden = true },
		live_grep = { hidden = true },
	},
}

return M
