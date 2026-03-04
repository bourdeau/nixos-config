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

  # Copy server.cfg and seeds.txt on activation
  system.activationScripts.copyRustConfigs = {
    text = ''
      # Copy server.cfg
      cp -f ${./rust/server.cfg} /var/lib/rust/server/server/rustux/cfg/server.cfg
      chmod 644 /var/lib/rust/server/server/rustux/cfg/server.cfg

      # Copy seeds.txt
      cp -f ${./rust/seeds.txt} /var/lib/rust/server/seeds.txt
      chmod 644 /var/lib/rust/server/seeds.txt
    '';
  };

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

        # -------------------------
        # Countdown
        # -------------------------
        for i in $(seq 300 -1 0); do
          if [ "$i" -gt 60 ] && [ $((i % 30)) -eq 0 ]; then
            rcon say "Server will stop in $i seconds! (Weekly wipe)"
          elif [ "$i" -le 60 ] && [ "$i" -gt 10 ] && [ $((i % 10)) -eq 0 ]; then
            rcon say "Server will stop in $i seconds! (Weekly wipe)"
          elif [ "$i" -le 10 ]; then
            rcon say "Server will stop in $i seconds! (Weekly wipe)"
          fi
          sleep 1
        done

        # Restart via RCON
        rcon-cli --host 127.0.0.1 --port 28016 --password "$RCON_PASS" restart 300 "Weekly wipe"
      '';
    };
    wants = ["rust-server.service"];
    after = ["rust-server.service"];
  };

  systemd.timers.rust-weekly-wipe = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "Wed 18:00";
      Persistent = true;
    };
  };

  ## =========================
  ## Force wipe
  ## =========================
  systemd.services.rust-force-wipe = {
    description = "Rust force wipe";
    serviceConfig = {
      Type = "oneshot";
      User = "rust";
      WorkingDirectory = "/var/lib/rust/server";

      LoadCredential = [
        "rustRcon:/run/secrets/rustRcon"
      ];

      Environment = [
        "PATH=/run/current-system/sw/bin"
      ];

      ExecStart = pkgs.writeShellScript "rust-force-wipe" ''
        set -euo pipefail

        SERVER_CFG="/var/lib/rust/server/server/rustux/cfg/server.cfg"
        SEEDS_FILE="/var/lib/rust/server/seeds.txt"
        RCON_PASS="$(cat "$CREDENTIALS_DIRECTORY/rustRcon")"

        rcon() {
          rcon-cli --host 127.0.0.1 --port 28016 --password "$RCON_PASS" "$@"
        }

        # -------------------------
        # Pick next seed
        # -------------------------
        CURRENT_SEED=$(grep '^server.seed ' "$SERVER_CFG" | awk '{print $2}')
        echo "Current seed: $CURRENT_SEED"

        NEXT_SEED=$(awk -v cur="$CURRENT_SEED" '
        {
          if (found) { print; exit }
          if ($1 == cur) { found=1 }
        }' "$SEEDS_FILE")

        if [ -z "$NEXT_SEED" ]; then
          NEXT_SEED=$(head -n1 "$SEEDS_FILE")
        fi

        echo "Next seed: $NEXT_SEED"

        # -------------------------
        # Countdown
        # -------------------------
        for i in $(seq 300 -1 0); do
          if [ "$i" -gt 60 ] && [ $((i % 30)) -eq 0 ]; then
            rcon say "Server will stop in $i seconds! (Force wipe)"
          elif [ "$i" -le 60 ] && [ "$i" -gt 10 ] && [ $((i % 10)) -eq 0 ]; then
            rcon say "Server will stop in $i seconds! (Force wipe)"
          elif [ "$i" -le 10 ]; then
            rcon say "Server will stop in $i seconds! (Force wipe)"
          fi
          sleep 1
        done

        # -------------------------
        # Save & stop
        # -------------------------
        rcon server.save
        sleep 5
        rcon server.stop
        sleep 10

        # -------------------------
        # Update Rust
        # -------------------------
        ${pkgs.steamcmd}/bin/steamcmd \
          +force_install_dir /var/lib/rust/server \
          +login anonymous \
          +app_update 258550 validate \
          +quit

        # -------------------------
        # Update seed
        # -------------------------
        sed -i "s/^server.seed .*/server.seed $NEXT_SEED/" "$SERVER_CFG"

        # -------------------------
        # Restart server
        # -------------------------
        systemctl start rust-server.service
      '';
    };

    wants = ["rust-server.service"];
    after = ["rust-server.service"];
  };

  systemd.timers.rust-force-wipe = {
    wantedBy = ["timers.target"];
    timerConfig = {
      # First Thursday of the month at 19:00
      OnCalendar = "Thu *-*-1..7 19:00";
      Persistent = true;
    };
  };
}
