local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixpkgs_fmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
