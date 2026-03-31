{config, ...}: {
  sops = {
    gnupg.home = "/root/.gnupg";
    defaultSopsFile = ./secrets.yaml;
    secrets.protonvpn-key = {
      sopsFile = ./secrets.yaml;
    };
  };

  networking.wg-quick.interfaces.proton = {
    address = ["10.2.0.2/32"];
    dns = ["10.2.0.1"];
    privateKeyFile = config.sops.secrets.protonvpn-key.path;
    peers = [
      {
        publicKey = "zcfEQgUoPLK2kvDicsA/4B9F2AI7qfxX5ueDo/Zcjj4=";
        allowedIPs = ["0.0.0.0/0" "::/0"];
        endpoint = "149.36.51.3:51820";
      }
    ];
    autostart = false;
  };
}
