{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  # Initial config so hyprpaper has something to start with
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/ph/Images/wallpapers/*
    wallpaper = HDMI-A-2,/home/ph/Images/wallpapers/1.jpg
  '';

  # Random wallpaper script
  home.file.".local/bin/random-wallpaper.sh".text = ''
    #!/usr/bin/env bash
    WALLPAPER_DIR="$HOME/Images/wallpapers/"
    CURRENT_WALL=$(hyprctl hyprpaper listloaded)
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Preload the new wallpaper
    hyprctl hyprpaper preload "$WALLPAPER"

    # Get monitor names (first column in `hyprctl monitors`)
    MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

    # Apply wallpaper to all monitors
    for MON in $MONITORS; do
        hyprctl hyprpaper wallpaper "$MON","$WALLPAPER"
    done
  '';
  home.file.".local/bin/random-wallpaper.sh".executable = true;

  # Systemd service to run the script
  systemd.user.services.random-wallpaper = {
    Unit = {
      Description = "Random wallpaper changer";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.local/bin/random-wallpaper.sh";
    };
  };

  # Timer: run the service every minute
  systemd.user.timers.random-wallpaper = {
    Unit = {
      Description = "Rotate wallpaper every minute";
    };
    Timer = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
