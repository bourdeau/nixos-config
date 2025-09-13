{ lib, ... }:
let
  terminal = "alacritty";
  splitToLines = s: lib.splitString "\n" s;
  browser = "firefox";
  wofiLauncher = ''$(wofi --show drun --define=drun-print_desktop_file=true | sed -E "s/(\.desktop) /\1:/")'';
in
{
  gtk.enable = true;
  qt.enable = true;
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = splitToLines ''
        hyprpaper
        waybar
        [workspace 1 silent] ${browser}
        [workspace 2 silent] ${terminal}
      '';
      input = {
        kb_layout = "us";
      };

      general = {
        layout = "dwindle";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
      };

      bind = [
        "CTRL ALT, t, exec, uwsm app -- alacritty"
        "CTRL ALT, right, workspace, +1"
        "CTRL ALT, left, workspace, -1"
        "CTRL ALT, f, exec, uwsm app -- [workspace 1 silent] ${browser}"
        "CTRL ALT, n, exec, uwsm app -- thunar"
        "CTRL, Q, killactive,"
        "SUPER, F, fullscreen, 0"
        "SUPER SHIFT, F, fullscreen, 1"
        "SUPER, Space, exec, togglefloating"
        "ALT, Escape, exec, uwsm app -- loginctl lock-session"
        "SUPER, R, exec, uwsm app -- ${wofiLauncher}"
        # Whole screen → save to ~/Images/Screenshots AND copy to clipboard
        "CTRL ALT, S, exec, hyprshot -m output -o ~/Images/Screenshots"

        # Active window → save + clipboard
        "CTRL ALT, W, exec, hyprshot -m window -m active -o ~/Images/Screenshots"

        # Region selection → save + clipboard
        "CTRL ALT SHIFT, S, exec, hyprshot -m region -o ~/Images/Screenshots"

        # switch focus
        "SUPER, h, movefocus, l"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"
        "SUPER, l, movefocus, r"

        "SUPER, h, alterzorder, top"
        "SUPER, j, alterzorder, top"
        "SUPER, k, alterzorder, top"
        "SUPER, l, alterzorder, top"

        # move focused window to workspaces 1–9
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"

        # Volume
        "SUPER, F11, exec, pamixer -d 5"
        "SUPER, F12, exec, pamixer -i 5"
        "SUPER, F10, exec, pamixer -t"

        # Brightness
        "SUPER, F5, exec, brightnessctl set 10%-"
        "SUPER, F6, exec, brightnessctl set +10%"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
    extraConfig = ''
      monitor = HDMI-A-2, 3840x2160@240, 0x0, 2
      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
