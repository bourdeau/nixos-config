{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cmake
    gcc
    gnumake
    gnupg

    wget
    curl

    # Git
    git
    lazygit

    # System
    sysstat
    lm_sensors # for `sensors` command
    neofetch
    xfce.thunar # xfce4's file manager
    nnn # terminal file manager
    ethtool
    pciutils # lspci
    usbutils # lsusb
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    gping # ping but with graph
    duf # disk usage


    # Needed by some Rust lib
    pkg-config

    # Browser 
    firefox
    lynx

    # Archives
    zip
    unzip
    p7zip

    # Utils
    ripgrep
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    xclip

    # IDE
    insomnia
    vscode

    # Cloud native
    docker
    kubectl
    terraform

    # Misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    libnotify
    xdg-utils

    # productivity
    glow # markdown previewer in terminal

    # shell
    nushell
    carapace

    # Communication
    slack

    # rust
    # rustup
    rust-analyzer
    cargo
    rustfmt

    # Python
    poetry
    nodePackages.pyright # python language server
    (python312.withPackages (
      ps:
        with ps; [
          ruff-lsp
          requests
        ]
    ))

    nodejs

    # Lua
    stylua
    lua-language-server

    tree-sitter 

];

  programs = {

    btop.enable = true;
    eza.enable = true;
    ssh.enable = true;
    aria2.enable = true;
    
  };

  services = {
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
