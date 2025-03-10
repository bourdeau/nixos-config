return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "bash", 
        "python",
        "cmake", 
        "dockerfile",
        "gitignore", 
        "go",
        "graphql",
        "hcl",
        "http",
        "javascript",
        "json",
        "make",
        "markdown",
        "rust",
        "sql",
        "terraform",
        "toml",
        "xml",
        "yaml",
  		},
  	},
  },

  -- MASON doesn't work on NixOS. See: https://github.com/williamboman/mason.nvim/issues/428
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "rust-analyzer",
  --       "pyright",
  --     },
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
}
