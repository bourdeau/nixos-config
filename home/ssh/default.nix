_: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      Compression = true;
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
    };

    settings.rustux = {
      HostName = "ns3106464.ip-54-36-126.eu";
      User = "ph";
      IdentityFile = "~/.ssh/id_ed25519";
      Port = 22;
    };
  };
}
