{ config, pkgs, ... }:
let
  uwsmPrefix = "uwsm app --";
in
{
  # Power menu script
  xdg.configFile."waybar/scripts/power-menu.nu" = {
    executable = true;
    text =
      let
        entry = l: a: ''{ label: "${l}", action: "${a}" }'';
      in
      ''
        #!/usr/bin/env nu

        let choices = [
          ${(entry " Lock" "${uwsmPrefix} loginctl lock-session")}
          ${(entry " Suspend" "${uwsmPrefix} systemctl suspend")}
          ${(entry " Reboot" "${uwsmPrefix} systemctl reboot")}
          ${(entry "⏻ Power Off" "${uwsmPrefix} systemctl poweroff")}
          ${(entry " Logout" "${uwsmPrefix} hyprctl dispatch exit 0")}
        ]
        let menu = $choices | get label | str join "\n"
        let selected = (echo $menu | wofi --dmenu --width 200 --height 300 --prompt "Power" | str trim)
        if $selected != "" {
          let action = ($choices | where label == $selected | get action | first)
          let cmd = $action | split words
          run-external ...$cmd
        }
      '';
  };

  # udiskie script
  xdg.configFile."waybar/scripts/udiskie-status.nu" = {
    executable = true;
    text = ''
      #!/usr/bin/env nu

      try {
        let mnt = "/run/media/" + ($env.USER | default "")
        let count = if ($mnt | path exists) { (ls $mnt | length) } else { 0 }
        let icon = " "
        let tooltip = $"udiskie — mounted devices: ($count)\nLeft click: mount all\nMiddle click: open ($mnt)\nRight click: unmount all"
        { text: $icon, tooltip: $tooltip, class: "udiskie" } | to json -r | print
      } catch {|e|
        # On any error, still print valid JSON so Waybar keeps the module visible
        { text: " ", tooltip: "udiskie status: error", class: "udiskie error" } | to json | print
      }
    '';
  };

  programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 28;
      spacing = 8;

      modules-left = [ "hyprland/workspaces" ];
      modules-right = [
        "tray"
        "custom/udiskie"
        "cpu"
        "memory"
        "disk"
        "network"
        "pulseaudio"
        "battery"
        "clock"
        "custom/power"
      ];

      "custom/udiskie" = {
        return-type = "json";
        exec = "${config.xdg.configHome}/waybar/scripts/udiskie-status.nu";
        interval = 5;
        tooltip = true;
        on-click = "${uwsmPrefix} udiskie --mount";
        on-click-middle = "${uwsmPrefix} xdg-open /run/media/$USER";
        on-click-right = "${uwsmPrefix} udiskie-umount -a";
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
        format-wifi = " {essid} ({signalStrength}%)";
        format-ethernet = " {ifname}";
        format-disconnected = " No network";
        tooltip-format = "{ifname} via {gwaddr}";
      };

      tray = { spacing = 8; };

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
        format = "󰋊 {percentage_used}%";
        interval = 60;
      };
      battery = {
        format = "{icon} {capacity}%";
        format-icons = [ " " " " " " " " " " ];
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
        on-click = "${config.xdg.configHome}/waybar/scripts/power-menu.nu";
        tooltip = true;
        tooltip-format = "⏻  Click for options";
      };

      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{name}";
        on-click = "activate";
        persistent-workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
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
      #clock,
      #cpu,
      #memory,
      #disk,
      #battery,
      #custom-power {
        padding: 0 8px;
      }
    '';
  };
}

