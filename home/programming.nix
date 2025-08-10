{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # IDEs
    insomnia
    vscode

    # Shells
    carapace
    nushell
    tree-sitter

    # Task runner
    just

    # Cloud Native Tools
    docker
    kubectl
    terraform
    redis

    # Build Tools
    cmake
    gcc
    gnupg
    gnumake

    # Rust Development
    pkg-config
    openssl
    cargo
    rustc
    clippy
    rustfmt

    # Python Development
    poetry
    (python312.withPackages (ps: with ps; [
      requests
      ruff
    ]))

    # JavaScript / Node.js
    nodejs

    # Lua Development
    stylua

    # Nix tooling
    nixpkgs-fmt

    # LSP Servers
    nodePackages.bash-language-server
    clang-tools
    vscode-langservers-extracted # html, cssls, jsonls
    dockerfile-language-server-nodejs
    gopls
    lua-language-server
    pyright
    rust-analyzer
    sqls
    terraform-ls
    typescript-language-server
    yaml-language-server
  ];
}
