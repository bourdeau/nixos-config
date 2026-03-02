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
  environment.etc."rust/server/seeds.txt".text = builtins.readFile ./rust/seeds.txt;

  systemd.tmpfiles.rules = [
    "d /var/lib/rust/server/server/rustux/cfg 0755 rust rust -"
    "C /var/lib/rust/server/server/rustux/cfg/server.cfg 0644 rust rust - ${./rust/server.cfg}"
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
      OnCalendar = "06:00 UTC";
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

      ExecStart = "${pkgs.bash}/bin/bash -c ''
      set -e

      SERVER_CFG=\"/var/lib/rust/server/server/rustux/cfg/server.cfg\"
      SEEDS_FILE=\"/var/lib/rust/server/seeds.txt\"

      # Get current seed from server.cfg
      CURRENT_SEED=$(grep '^server.seed ' \"$SERVER_CFG\" | awk '{print \$2}')
      
      echo Current seed is: $CURRENT_SEED

      # Find the next line after the current seed in seeds.txt
      NEXT_SEED=$(awk -v cur=\"$CURRENT_SEED\" '{
        if(found){ print; exit }
        if(\$1 == cur){ found=1 }
      }' \"$SEEDS_FILE\")
      
      echo Next seed is: $NEXT_SEED

      # If current seed is last, loop to first
      if [ -z \"$NEXT_SEED\" ]; then
        NEXT_SEED=$(head -n1 \"$SEEDS_FILE\")
      fi

      # Replace server.seed in server.cfg
      sed -i \"s/^server.seed .*/server.seed $NEXT_SEED/\" \"$SERVER_CFG\"

      # Restart Rust server with RCON
      ${pkgs.rcon-cli}/bin/rcon-cli \
        --host 127.0.0.1 \
        --port 28016 \
        --password rustRconIljkqwhd6309qwdh9 \
        restart 300 \"Weekly wipe\"
    ''";
    };
  };

  systemd.timers.rust-weekly-wipe = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "Wed 06:00 UTC";
      Persistent = true;
    };
  };
}
