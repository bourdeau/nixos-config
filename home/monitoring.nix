{pkgs, ...}: {
  home.packages = with pkgs; [
    # System Monitoring and Management
    duf # Disk usage utility with fancy output
    iftop # Real-time console-based network bandwidth monitoring
    iotop # Top-like UI for monitoring disk I/O
    lm_sensors # Read temperature/voltage/fan sensors
    lsof # List open files
    ltrace # Display calls to dynamic libraries
    nnn # Terminal file manager
    pciutils # List and manipulate PCI devices
    strace # Monitor system calls
    sysstat # Performance monitoring tools for Linux
    usbutils # Manage USB devices
    lshw # List detailed hardware information
  ];
}
