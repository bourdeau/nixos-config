{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.wofi pkgs.pamixer pkgs.pavucontrol];

  home.file = {
    ".config/waybar/scripts/power-menu.nu" = {
      source = ./scripts/power-menu.nu;
      executable = true;
    };
    ".config/waybar/scripts/udiskie-status.nu" = {
      source = ./scripts/udiskie-status.nu;
      executable = true;
    };
    ".config/waybar/scripts/vpn-status.nu" = {
      source = ./scripts/vpn-status.nu;
      executable = true;
    };
    ".config/waybar/scripts/vpn-toggle.nu" = {
      source = ./scripts/vpn-toggle.nu;
      executable = true;
    };
    ".config/waybar/style.css".source = ./style.css;
  };

  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 28;
      spacing = 8;

      modules-left = ["hyprland/workspaces"];
      modules-right = [
        "tray"
        "custom/udiskie"
        "cpu"
        "memory"
        "disk"
        "custom/vpn"
        "network"
        "pulseaudio"
        "battery"
        "clock"
        "custom/power"
      ];

      "custom/udiskie" = {
        return-type = "json";
        exec = "${config.home.homeDirectory}/.config/waybar/scripts/udiskie-status.nu";
        interval = 5;
        tooltip = true;
        on-click = "uwsm app -- udiskie --mount";
        on-click-middle = "uwsm app -- xdg-open /run/media/$USER";
        on-click-right = "uwsm app -- udiskie-umount -a";
      };

      "custom/vpn" = {
        return-type = "json";
        exec = "$HOME/.config/waybar/scripts/vpn-status.nu";
        interval = 5;
        on-click = "$HOME/.config/waybar/scripts/vpn-toggle.nu";
      };

      clock = {
        format = "{:%d/%m/%Y ~ %H:%M}";
        tooltip-format = "{:%Y-%m-%d}";
      };

      pulseaudio = {
        format = " {volume}%";
        format-muted = "";
        scroll-step = 5;
        on-click = "${pkgs.pamixer}/bin/pamixer -t";
        on-click-right = "pavucontrol";
      };

      network = {
        format-wifi = "  {essid} ({signalStrength}%)";
        format-ethernet = " {ifname}";
        format-disconnected = " No network";
        tooltip-format = "{ifname} via {gwaddr}";
      };

      tray = {spacing = 8;};

      cpu = {
        format = " {usage}%";
        format-alt = " {avg_frequency} GHz";
        interval = 2;
      };
      memory = {
        format = " {}%";
        format-alt = " {used} GiB";
        interval = 2;
      };
      disk = {
        # Note: U+2009 (thin space) between 󰋊 and {percentage_used} to avoid spacing glitch
        format = "󰋊 {percentage_used}%";
        interval = 60;
      };
      battery = {
        format = "{icon} {capacity}%";
        format-icons = [" " " " " " " " " "];
        format-charging = " {capacity}%";
        format-full = " {capacity}%";
        format-warning = "{capacity}%";
        states.warning = 20;
        interval = 5;
        format-time = "{H}h{M}m";
        tooltip = true;
        tooltip-format = "{time}";
      };
      "custom/power" = {
        format = "⏻ ";
        on-click = "${config.home.homeDirectory}/.config/waybar/scripts/power-menu.nu";
        tooltip = true;
        tooltip-format = "⏻  Click for options";
      };

      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{name}";
        on-click = "activate";
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };
      };
    };
  };
}
