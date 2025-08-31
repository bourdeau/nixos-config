local M = {}

M.opts = {
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		-- attach default mappings from MvChad
		if api.config.mappings.default_on_attach then
			api.config.mappings.default_on_attach(bufnr)
		end

		local opts = { buffer = bufnr, noremap = true, silent = true }

		-- buffer-local resize mappings
		vim.keymap.set("n", "+", ":NvimTreeResize +5<CR>", opts)
		vim.keymap.set("n", "-", ":NvimTreeResize -5<CR>", opts)
	end,
}

return M
