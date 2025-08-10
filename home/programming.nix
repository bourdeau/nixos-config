{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # IDEs
    insomnia # API Client for GraphQL, REST, and gRPC
    vscode # Visual Studio Code

    # Shells
    carapace # Completion generator for Bash, Zsh, Fish, and PowerShell
    nushell # Modern shell for the GitHub era
    tree-sitter # Parser generator tool and an incremental parsing library

    just # Command runner and task automation tool

    # Cloud Native Tools
    docker # Platform for developing, shipping, and running applications
    kubectl # Command-line tool for controlling Kubernetes clusters
    terraform # Infrastructure as code tool
    redis

    # Build Tools
    cmake # Cross-platform build system
    gcc # GNU Compiler Collection
    gnupg # GNU Privacy Guard for encrypting and signing data
    gnumake # Control the generation of executables

    # Rust Development
    pkg-config # Needed by some Rust libraries
    openssl # Cryptography library

    # Rust Development Tools
    cargo # Rust package manager
    rust-analyzer # Rust language server
    rustfmt # Rust code formatter
    rustc # Rust compiler
    clippy # Linter for Rust code

    # Python Development Tools
    poetry # Python dependency management and packaging
    pyright
    (python312.withPackages (ps: with ps; [
      requests # HTTP library for Python
      ruff # Python linter
    ]))

    # JavaScript and Node.js
    nodejs # JavaScript runtime

    # Lua Development Tools
    lua-language-server # Language server for Lua
    stylua # Lua code formatter

    # Nix
    nixpkgs-fmt
  ];
}

