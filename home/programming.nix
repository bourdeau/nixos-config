{pkgs, ...}: {
  home.packages = with pkgs; [
    # Shells
    carapace
    tree-sitter

    # Task runner
    just
    mask # uses Markdown

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
    uv

    # JavaScript / Node.js
    nodejs

    # Lua Development
    stylua

    # Nix tooling
    nixpkgs-fmt
    alejandra # formatter
    statix # linter
    deadnix # detect unused definitions

    # Golang
    go

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
