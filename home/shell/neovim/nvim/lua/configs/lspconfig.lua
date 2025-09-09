local lsp_servers = {
	"bashls",
	"clangd",
	"cssls",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"pyright",
	"ts_ls",
	"yamlls",
	"rust_analyzer",
	"lua_ls",
}

-- Setup all mapped LSP servers
local lspconfig = require("lspconfig")
for _, server in ipairs(lsp_servers) do
	local opts = {
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	}

	-- Rust-specific config
	if server == "rust_analyzer" then
		opts.cmd = { "rust-analyzer" }
		opts.settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				procMacro = { enable = true },
			},
		}
	end

	-- Lua-specific config
	if server == "lua_ls" then
		opts.settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
			},
		}
	end

	lspconfig[server].setup(opts)
end

vim.o.signcolumn = "yes" -- ensure the gutter shows

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
