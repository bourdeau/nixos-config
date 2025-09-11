{ lib, pkgs, ... }:
let
  lockCmd = "pidof hyprlock || hyprlock";
  unlockCmd = "pkill --signal SIGUSR1 hyprlock";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    package = null;
    portalPackage = null;
  };
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "${lockCmd}";
          unlock_cmd = "${unlockCmd}";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "${lockCmd}";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "${lockCmd}";
          }
          {
            timeout = 360;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -s s 10%";
            on-resume = "brightnessctl -r";
          }
        ];
      };
    };
    hyprpolkitagent = {
      enable = true;
    };
    cliphist = {
      enable = true;
    };
    udiskie = {
      enable = true;
      automount = true;
      tray = "always";
    };
  };
}
