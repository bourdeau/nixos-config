{pkgs, ...}: {
  home.packages = with pkgs; [
    # Archive Tools
    p7zip # File archiver with a high compression ratio
    unzip # Extract zip archives
    zip # Create zip archives

    # Utilities
    eza # Modern replacement for 'ls'
    fzf # Command-line fuzzy finder
    ripgrep # Line-oriented search Tools
    fd # find replacement
    xclip # Command line interface to the X11 clipboard
    zoxide # Fast cd command that learns your habits
    yazi # terminal file manager
    tokei # count files in a project and group
    presenterm # a TUI markdown terminal slideshow tool.
    manix # Not the French condoms brand... search NixOS and Home Manager options from the terminal
    zathura # pdf viewer

    # Miscellaneous
    file # Determine file type
    figlet # Generate ASCII art from text
    gawk # Pattern scanning and processing language
    glow # Terminal-based markdown viewer
    gnused # GNU version of the stream editor
    gnutar # GNU version of tar archiving utility
    libnotify # Library for sending desktop notifications
    tree # Display directories as trees
    xdg-utils # Utilities for managing X desktop environments
    zstd # Fast lossless compression algorithm
    sops # Secret Manager

    # Communication
    discord
    signal-desktop
  ];

  programs = {
    eza.enable = true;
    aria2.enable = true;

    ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks."*" = {
        compression = true;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };
    };
  };

  services = {
    syncthing.enable = true;
    # auto mount usb drives
    udiskie.enable = true;
  };
}
