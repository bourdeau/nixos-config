{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ eww ];

  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      After = [ "graphical.target" ];
    };
    Service = {
      ExecStart = "${pkgs.eww}/bin/eww daemon";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.sessionVariables = {
    EWW_CONFIG_DIR = "${config.home.homeDirectory}/.config/eww";
  };

  # Start bar after login
  systemd.user.services."eww-bar" = {
    Unit = {
      Description = "Open Eww bar";
      After = [ "eww.service" ];
      Wants = [ "eww.service" ];
    };
    Service = {
      ExecStart = "${pkgs.eww}/bin/eww open bar";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
