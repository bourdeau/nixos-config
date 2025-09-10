{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 8;

        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "network" "pulseaudio" "clock" ];

        clock = {
          format = "{:%d/%m/%Y ~ %H:%M}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        pulseaudio = {
          format = " {volume}%";
          format-muted = "";
          scroll-step = 5;
          on-click = "${pkgs.pamixer}/bin/pamixer -t";
        };

        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = " No network";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font, sans-serif;
        font-size: 13px;
      }

      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
      }

      #workspaces button.active {
        background: #89b4fa;
        color: #1e1e2e;
      }

      #workspaces button {
        padding: 0 6px;
        margin: 2px;
      }

      #tray,
      #network,
      #pulseaudio,
      #clock {
        padding: 0 8px;
      }
    '';
  };
}
