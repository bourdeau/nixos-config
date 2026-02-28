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
      Environment = "LD_LIBRARY_PATH=/var/lib/rust/server:${pkgs.steam-run}/lib";

      # Run SteamCMD once before starting the server
      ExecStartPre = ''
        ${pkgs.steamcmd}/bin/steamcmd \
          +force_install_dir /var/lib/rust/server \
          +login anonymous \
          +app_update 258550 validate \
          +quit
      '';

      ExecStart = ''
        ${pkgs.steam-run}/bin/steam-run /var/lib/rust/server/RustDedicated \
          -batchmode -nographics \
          +app.listenip 0.0.0.0 \
          +app.port 28082 \
          +server.ip 0.0.0.0 \
          +server.port 28015 \
          +server.queryport 28017 \
          +server.tickrate 30 \
          +fps.limit 60 \
          +server.url "https://rustux.eu" \
          +server.hostname "[EU] Rustux | Wednesday | Linux, Steam Deck & Windows" \
          +server.description "Welcome to [EU] Rustux, the Vanilla server for Linux, Steam Deck & Windows Players!\n\nGeneral information:\n- Linux, Steam Deck and Windows\n- Vanilla: No mods, no pay-to-win\n- Wipe schedule: Weekly @ Wednesday\n- Map size: 4000\n- Group limit: 5\n➤ Bare metal server, low latency, and smooth gameplay\n\nRules:\n1. No Cheating or Exploiting\n2. No Toxicity or Harassment\n3. Fair PVP\n4. Building Restrictions\n5. Respect Server Performance\n6. No Abusing Game Mechanics" \
          +server.identity "rustux" \
          +server.gamemode "vanilla" \
          +server.globalchat false \
          +server.level "Procedural Map" \
          +server.seed 1930813691 \
          +server.salt "1" \
          +server.maxplayers 100 \
          +server.worldsize 4000 \
          +server.saveinterval 300 \
          +server.secure "0" \
          +server.encryption "0" \
          server.eac "0" \
          +rcon.web 1 \
          +rcon.ip 0.0.0.0 \
          +rcon.port 28016 \
          +rcon.password "rustRconIljkqwhd6309qwdh9" \
          +server.tags "weekly,vanilla,EU" \
          -logfile "/var/lib/rust/server/logs/server.log"
      '';
      Restart = "no";
      LimitNOFILE = 100000;
    };
  };

  environment.systemPackages = with pkgs; [
    steamcmd
    steam-run
  ];
}
