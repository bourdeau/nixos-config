{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.swaynotificationcenter ];

  systemd.user.services.swaync = {
    Unit = {
      Description = "Sway Notification Center";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
