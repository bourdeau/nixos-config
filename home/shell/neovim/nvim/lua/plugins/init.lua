local treesitter_langs = require("configs.langs")

return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- format on save
		opts = require("configs.conform"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = treesitter_langs,
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig")
			require("configs.lspconfig")
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = function(_, opts)
			local custom = require("configs.nvimtree").opts
			return vim.tbl_deep_extend("force", opts, custom)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = require("configs.telescope").opts,
	},
}
