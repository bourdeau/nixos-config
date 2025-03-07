{
  lib,
  pkgs,
  ...
}: {
home.packages = with pkgs; [
  # Build Tools
  cmake        # Cross-platform build system
  gcc          # GNU Compiler Collection
  gnupg        # GNU Privacy Guard for encrypting and signing data
  gnumake      # Control the generation of executables

  # Networking Tools
  curl         # Command-line tool for transferring data with URLs
  ethtool      # Display and modify network interface controller parameters
  gping        # Ping with a graph
  iftop        # Real-time console-based network bandwidth monitoring
  pciutils     # List and manipulate PCI devices
  usbutils     # Manage USB devices
  wget         # Network utility to retrieve files from the web

  # Version Control
  git          # Distributed version control system
  gitflow      # Extensions to Git for managing workflows
  lazygit      # Simple terminal UI for Git commands

  # System Monitoring and Management
  btop         # Resource monitor replacing htop/nmon
  duf          # Disk usage utility with fancy output
  iftop        # Real-time console-based network bandwidth monitoring
  iotop        # Top-like UI for monitoring disk I/O
  lm_sensors   # Read temperature/voltage/fan sensors
  lsof         # List open files
  ltrace       # Display calls to dynamic libraries
  neofetch     # Command-line system information tool
  nnn          # Terminal file manager
  pciutils     # List and manipulate PCI devices
  strace       # Monitor system calls
  sysstat      # Performance monitoring tools for Linux
  usbutils     # Manage USB devices
  xfce.thunar  # XFCE's file manager
  lshw

  # Rust Development
  pkg-config   # Needed by some Rust libraries
  openssl      # Cryptography library

  # Browsers
  firefox      # Web browser
  lynx         # Text-based web browser

  # Archive Tools
  p7zip        # File archiver with a high compression ratio
  unzip        # Extract zip archives
  zip          # Create zip archives

  # Utilities
  eza          # Modern replacement for 'ls'
  fzf          # Command-line fuzzy finder
  ripgrep      # Line-oriented search tool
  xclip        # Command line interface to the X11 clipboard

  # IDEs
  insomnia     # API Client for GraphQL, REST, and gRPC
  vscode       # Visual Studio Code

  # Image Editing
  gimp         # GNU Image Manipulation Program

  # Audio Editing
  audacity     # Audio editor and recorder

  # Cloud Native Tools
  docker       # Platform for developing, shipping, and running applications
  kubectl      # Command-line tool for controlling Kubernetes clusters
  terraform    # Infrastructure as code tool
  redis

  # Miscellaneous
  file         # Determine file type
  figlet       # Generate ASCII art from text
  gawk         # Pattern scanning and processing language
  glow         # Terminal-based markdown viewer
  gnused       # GNU version of the stream editor
  gnutar       # GNU version of tar archiving utility
  libnotify    # Library for sending desktop notifications
  tree         # Display directories as trees
  xdg-utils    # Utilities for managing X desktop environments
  zstd         # Fast lossless compression algorithm

  # Shells
  carapace     # Completion generator for Bash, Zsh, Fish, and PowerShell
  nushell      # Modern shell for the GitHub era

  # Communication
  slack        # Collaboration software

  # Sound Management
  easyeffects  # Audio effects for PipeWire applications

  # Rust Development Tools
  cargo         # Rust package manager
  rust-analyzer # Rust language server
  rustfmt       # Rust code formatter
  rustc         # Rust compiler
  clippy        # Linter for Rust code

  # Python Development Tools
  poetry          # Python dependency management and packaging
  pyright
  (python312.withPackages (ps: with ps; [
    requests      # HTTP library for Python
    ruff          # Python linter
    ruff-lsp      # Language server for the Ruff Python linter
  ]))

  # JavaScript and Node.js
  nodejs         # JavaScript runtime

  # Lua Development Tools
  lua-language-server # Language server for Lua
  stylua         # Lua code formatter

  tree-sitter    # Parser generator tool and an incremental parsing library
  just           # Command runner and task automation tool
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
