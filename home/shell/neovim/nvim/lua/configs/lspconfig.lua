-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local servers = { 
  "html",
  "cssls",
  "pyright",
}

-- Load LSPs with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Configure rust-analyzer to use the system version from Nix
lspconfig.rust_analyzer.setup {
  cmd = { "rust-analyzer" }, -- Use system rust-analyzer
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
}
