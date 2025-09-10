{ lib, ... }:
let
  terminal = "alacritty";
  splitToLines = s: lib.splitString "\n" s;
  browser = "firefox";
  uwsmPrefix = "uwsm app --";
  wofiLauncher = ''$(wofi --show drun --define=drun-print_desktop_file=true | sed -E "s/(\.desktop) /\1:/")'';
in
{
  gtk.enable = true;
  qt.enable = true;
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = splitToLines ''
        [workspace 1 silent] ${browser}
        [workspace 2 silent] ${terminal}
        waybar
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
        "SUPER, F1, exec, show-keybinds"
        "CTRL ALT, t, exec, alacritty"
        "CTRL ALT, right, workspace, +1"
        "CTRL ALT, left, workspace, -1"
        "CTRL ALT, f, exec, [workspace 1 silent] ${browser}"
        "CTRL, Q, killactive,"
        "SUPER, F, fullscreen, 0"
        "SUPER SHIFT, F, fullscreen, 1"
        "SUPER, Space, exec, togglefloating"
        "ALT, Escape, exec, loginctl lock-session"
        "SUPER, R, exec, ${wofiLauncher}"

        # switch focus
        "SUPER, h, movefocus, l"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"
        "SUPER, l, movefocus, r"

        "SUPER, h, alterzorder, top"
        "SUPER, j, alterzorder, top"
        "SUPER, k, alterzorder, top"
        "SUPER, l, alterzorder, top"

        # Volume / brightness
        ",XF86AudioRaiseVolume, exec, pamixer -i 5"
        ",XF86AudioLowerVolume, exec, pamixer -d 5"
        ",XF86AudioMute, exec, pamixer -t"
        ",XF86AudioMicMute, exec, pamixer -m"

        ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
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
