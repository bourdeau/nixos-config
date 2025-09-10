{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ eww ];

  home.sessionVariables = {
    EWW_CONFIG_DIR = "${config.home.homeDirectory}/.config/eww";
  };

  systemd.user.services."eww" = {
    Unit = {
      Description = "Eww daemon";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services."eww-bar" = {
    Unit = {
      Description = "Open Eww bar";
      After = [ "eww.service" "graphical-session.target" ];
      Wants = [ "eww.service" "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.eww}/bin/eww open bar";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
