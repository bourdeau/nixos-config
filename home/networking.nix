{pkgs, ...}: {
  home.packages = with pkgs; [
    curl # Command-line tool for transferring data with URLs
    ethtool # Display and modify network interface controller parameters
    gping # Ping with a graph
    iftop # Real-time console-based network bandwidth monitoring
    pciutils # List and manipulate PCI devices
    usbutils # Manage USB devices
    wget # Network utility to retrieve files from the web
    lftp # Command-line FTP/HTTP/SFTP client
    impala
    iwd
  ];
}
