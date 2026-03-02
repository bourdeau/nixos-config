{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    steamcmd
    steam-run
    rcon-cli
  ];

  networking.firewall.allowedUDPPorts = [
    28015
    28017
    28082
  ];

  networking.firewall.allowedTCPPorts = [
    28016
    28083
  ];

  users.groups.rust = {};

  users.users.rust = {
    isSystemUser = true;
    group = "rust";
    home = "/var/lib/rust";
    createHome = true;
  };

  environment.etc."rust/server/rustux/cfg/server.cfg".text = builtins.readFile ./rust/server.cfg;
  environment.etc."rust/server/rustux/script/weekly-wipe.sh".text = builtins.readFile ./rust/weekly-wipe.sh;
  environment.etc."rust/server/seeds.txt".text = builtins.readFile ./rust/seeds.txt;

  systemd.tmpfiles.rules = [
    "d /var/lib/rust/server/server/rustux/cfg 0755 rust rust -"
    "d /var/lib/rust/server/server/rustux/script 0755 rust rust -"
    "C /var/lib/rust/server/server/rustux/cfg/server.cfg 0644 rust rust - ${./rust/server.cfg}"
    "C /var/lib/rust/server/server/rustux/script/weekly-wipe.sh 0755 rust rust - ${./rust/weekly-wipe.sh}"
    "C /var/lib/rust/server/seeds.txt 0644 rust rust - ${./rust/seeds.txt}"
  ];

  ## =========================
  ## Rust server
  ## =========================
  systemd.services.rust-server = {
    description = "Rust Dedicated Server";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      User = "rust";
      WorkingDirectory = "/var/lib/rust/server";
      Environment = "LD_LIBRARY_PATH=/var/lib/rust/server:${pkgs.steam-run}/lib";

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
          +server.identity "rustux" \
          +rcon.ip 0.0.0.0 \
          +rcon.port 28016 \
          +rcon.password "rustRconIljkqwhd6309qwdh9" \
          -logfile /var/lib/rust/server/logs/server.log
      '';

      Restart = "always";
      RestartSec = 10;
      LimitNOFILE = 100000;
    };
  };

  ## =========================
  ## Daily restart
  ## =========================
  systemd.services.rust-rcon-restart = {
    description = "Rust daily restart";
    serviceConfig = {
      Type = "oneshot";
      User = "rust";

      ExecStart = ''
        ${pkgs.rcon-cli}/bin/rcon-cli \
          --host 127.0.0.1 \
          --port 28016 \
          --password rustRconIljkqwhd6309qwdh9 \
          restart 300 "Daily restart"
      '';
    };
  };

  systemd.timers.rust-rcon-restart = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "06:00";
      Persistent = true;
    };
  };

  ## =========================
  ## Weekly wipe (seed rotation)
  ## =========================
  systemd.services.rust-weekly-wipe = {
    description = "Rust weekly wipe";
    serviceConfig = {
      Type = "oneshot";
      User = "rust";
      WorkingDirectory = "/var/lib/rust/server";
      Environment = [
        "PATH=/run/current-system/sw/bin"
      ];
      ExecStart = "/var/lib/rust/server/server/rustux/script/weekly-wipe.sh";
    };
  };

  systemd.timers.rust-weekly-wipe = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "Wed 18:00";
      Persistent = true;
    };
  };
}
