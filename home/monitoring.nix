{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System Monitoring and Management
    btop # Resource monitor replacing htop/nmon
    duf # Disk usage utility with fancy output
    iftop # Real-time console-based network bandwidth monitoring
    iotop # Top-like UI for monitoring disk I/O
    lm_sensors # Read temperature/voltage/fan sensors
    lsof # List open files
    ltrace # Display calls to dynamic libraries
    neofetch # Command-line system information tool
    nnn # Terminal file manager
    pciutils # List and manipulate PCI devices
    strace # Monitor system calls
    sysstat # Performance monitoring tools for Linux
    usbutils # Manage USB devices
    xfce.thunar # XFCE's file manager
    lshw
  ];

  programs = {
    btop.enable = true;
  };
}

