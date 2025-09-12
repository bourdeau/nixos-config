local nvlsp = require("nvchad.configs.lspconfig")
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities
local lspconfig = require("lspconfig")

local lsp_servers = {
	"bashls",
	"clangd",
	"cssls",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"nushell",
	"pyright",
	"rust_analyzer",
	"ts_ls",
	"yamlls",
}

-- Setup all mapped LSP servers
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

	-- Nushell LSP (`nu --lsp`) is still experimental:
	--  ✓ completions
	--  ✓ hover docs
	--  ✓ semantic tokens (highlighting)
	--  ✗ diagnostics (no error reporting yet)
	-- So invalid syntax won't be underlined until they implement diagnostics.
	if server == "nushell" then
		opts.cmd = { "nu", "--lsp" }
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
