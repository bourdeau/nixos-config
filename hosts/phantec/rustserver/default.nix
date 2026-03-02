{
  config,
  pkgs,
  ...
}: {
  sops = {
    gnupg.home = "/root/.gnupg";
    secrets = {
      rustRcon = {
        sopsFile = ../../../modules/secrets.yaml;
        owner = "rust";
      };
    };
  };

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

  ## =========================
  ## Rust server
  ## =========================
  systemd.services.rust-server = {
    description = "Rust Dedicated Server";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    environment = {
      LD_LIBRARY_PATH = "/var/lib/rust/server:${pkgs.steam-run}/lib";
    };

    serviceConfig = {
      User = "rust";
      WorkingDirectory = "/var/lib/rust/server";

      ExecStartPre = ''
        ${pkgs.steamcmd}/bin/steamcmd \
          +force_install_dir /var/lib/rust/server \
          +login anonymous \
          +app_update 258550 validate \
          +quit
      '';

      ExecStart = pkgs.writeShellScript "rust-server-start" ''
        exec ${pkgs.steam-run}/bin/steam-run /var/lib/rust/server/RustDedicated \
          -batchmode -nographics \
          +server.identity "rustux" \
          +rcon.ip 0.0.0.0 \
          +rcon.port 28016 \
          +rcon.password "$(cat /run/secrets/rustRcon)" \
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

      ExecStart = pkgs.writeShellScript "rust-rcon-restart" ''
        "${pkgs.rcon-cli}/bin/rcon-cli" \
          --host 127.0.0.1 \
          --port 28016 \
          --password "$(cat /run/secrets/rustRcon)" \
          restart 300 "Daily restart"
      '';
    };
    wants = ["rust-server.service"];
    after = ["rust-server.service"];
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
      LoadCredential = [
        "rustRcon:/run/secrets/rustRcon"
      ];
      WorkingDirectory = "/var/lib/rust/server";
      Environment = [
        "PATH=/run/current-system/sw/bin"
      ];
      ExecStart = pkgs.writeShellScript "rust-weekly-wipe" ''
        set -euo pipefail

        SERVER_CFG="/var/lib/rust/server/server/rustux/cfg/server.cfg"
        SEEDS_FILE="/var/lib/rust/server/seeds.txt"

        # Get current seed
        CURRENT_SEED=$(grep '^server.seed ' "$SERVER_CFG" | awk '{print $2}')
        echo "Current seed is: $CURRENT_SEED"

        # Find next seed
        NEXT_SEED=$(awk -v cur="$CURRENT_SEED" '
        {
          if (found) { print; exit }
          if ($1 == cur) { found=1 }
        }' "$SEEDS_FILE")

        if [ -z "$NEXT_SEED" ]; then
          NEXT_SEED=$(head -n1 "$SEEDS_FILE")
        fi
        echo "Next seed is: $NEXT_SEED"

        # Update server.cfg
        sed -i "s/^server.seed .*/server.seed $NEXT_SEED/" "$SERVER_CFG"

        # Read RCON password
        RCON_PASS="$(cat "$CREDENTIALS_DIRECTORY/rustRcon")"
        echo "Restarting server with RCON password"

        sleep 5

        # Restart via RCON
        rcon-cli --host 127.0.0.1 --port 28016 --password "$RCON_PASS" restart 300 "Weekly wipe"
      '';
      wants = ["rust-server.service"];
      after = ["rust-server.service"];
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
