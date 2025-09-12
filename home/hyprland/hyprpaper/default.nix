{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    nushell
  ];

  home.file = {
    # Initial config so hyprpaper has something to start with
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/.config/hypr/wallpapers/*
      wallpaper = HDMI-A-2,~/.config/hypr/wallpapers/1.jpg
    '';

    # Deploy wallpapers from repo. Home manager will own this dir.
    ".config/hypr/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };

    # Random script
    ".config/hypr/scripts/random-wallpaper.nu" = {
      source = ./scripts/random-wallpaper.nu;
      executable = true;
    };
  };

  # Systemd service to run the script
  systemd.user.services.random-wallpaper = {
    Unit = {
      Description = "Random wallpaper changer (Nu)";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.config/hypr/scripts/random-wallpaper.nu";
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
