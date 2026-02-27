{
  config,
  pkgs,
  ...
}: {
  networking.firewall.allowedUDPPorts = [28015 28016];

  users.groups.rust = {};

  users.users.rust = {
    isSystemUser = true;
    group = "rust";
    home = "/var/lib/rust";
    createHome = true;
  };

  systemd.services.rust-server = {
    description = "Rust Dedicated Server";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      User = "rust";
      WorkingDirectory = "/var/lib/rust/server";

      # Run SteamCMD once before starting the server
      ExecStartPre = ''
        ${pkgs.steamcmd}/bin/steamcmd \
          +force_install_dir /var/lib/rust/server \
          +login anonymous \
          +app_update 258550 validate \
          +quit
      '';

      # Run RustDedicated inside steam-run (Steam runtime)
      ExecStart = ''
        ${pkgs.steam-run}/bin/steam-run /var/lib/rust/server/RustDedicated \
          -batchmode -nographics \
          +app.listenip $IP \
          +app.port $APPORT \
          +server.ip $IP \
          +server.port $PORT \
          +server.queryport $QUERYPORT \
          +server.tickrate $TICKRATE \
          +server.hostname "$SERVERNAME" \
          +server.description "$SERVERDESCRIPTION" \
          +server.identity "$SELFNAME" \
          +server.gamemode $GAMEMODE \
          +server.level "$SERVERLEVEL" \
          +server.seed $SEED \
          +server.salt $SALT \
          +server.maxplayers $MAXPLAYERS \
          +server.worldsize $WORLDSIZE \
          +server.saveinterval $SAVEINTERVAL \
          +rcon.web $RCONWEB \
          +rcon.ip $IP \
          +rcon.port $RCONPORT \
          +rcon.password "$RCONPASSWORD" \
          +server.tags "$TAGS" \
          -logfile "$GAMELOG"
      '';

      Restart = "always";
      LimitNOFILE = 100000;
    };
  };

  environment.systemPackages = with pkgs; [
    steamcmd
    steam-run
  ];
}
