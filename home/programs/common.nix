{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    p7zip

    # utils
    ripgrep
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # misc
    libnotify

    xdg-utils

    # IDE
    insomnia

    # cloud native
    docker
    kubectl

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # productivity
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # shell
    nushell
    carapace

    vscode
    slack

    # rust
    rust-analyzer
    cargo
    rustfmt

    # python
    python312
    poetry

    nodejs

    lynx
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
