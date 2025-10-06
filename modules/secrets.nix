{config, ...}: {
  sops = {
    gnupg.home = "/root/.gnupg";
    defaultSopsFile = ./secrets.yaml;
    secrets.protonvpn = {
      sopsFile = ./secrets.yaml;
    };
  };

  networking.wg-quick.interfaces.proton = {
    configFile = config.sops.secrets.protonvpn.path;
    autostart = false;
  };
}
