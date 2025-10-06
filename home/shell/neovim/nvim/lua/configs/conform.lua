local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "alejandra" },
		json = { "prettier" },
		yaml = { "prettier" },
		toml = { "taplo" },
		markdown = { "prettier" },
		python = { "ruff_format", "ruff_organize_imports" },
		rust = { "rustfmt" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return options
