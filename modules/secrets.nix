{
  config,
  pkgs,
  ...
}: {
  sops.gnupg.home = "/root/.gnupg";
  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets.protonvpn = {
    sopsFile = ./secrets.yaml;
  };

  networking.wg-quick.interfaces.proton = {
    configFile = config.sops.secrets.protonvpn.path;
    autostart = true;
  };
}
