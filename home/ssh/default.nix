{pkgs, ...}: {
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks."*" = {
        compression = true;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };

      extraConfig = ''
        Host rustux
          HostName ns3106464.ip-54-36-126.eu
          User ph
          IdentityFile ~/.ssh/id_ed25519
          Port 22
      '';
    };
  };
}
