{ pkgs, ... }:
{
  home.packages = with pkgs; [ eww ];

  home.file.".config/eww/eww.yuck".text = ''
    ;; ------------------------------
    ;; Top bar
    ;; ------------------------------

    (defwidget bar []
      (box :orientation "h" :halign "fill" :hexpand true
        ;; left side
        (workspaces)

        ;; expand middle empty space
        (box :hexpand true)

        ;; right side (wifi, volume, battery, clock)
        (box :orientation "h" :spacing 15 :halign "end"
          (sysinfo)
          (clock-widget))))

    (defwidget workspaces []
      (box :class "workspaces" :orientation "h" :spacing 8
        (button :onclick "hyprctl dispatch workspace 1" "1")
        (button :onclick "hyprctl dispatch workspace 2" "2")
        (button :onclick "hyprctl dispatch workspace 3" "3")
        (button :onclick "hyprctl dispatch workspace 4" "4")
        (button :onclick "hyprctl dispatch workspace 5" "5")))

    (defwidget sysinfo []
      (box :class "sysinfo" :orientation "h" :spacing 15
        (label :text { " " + network } :class "net")
        (label :text { " " + volume + "%" } :class "vol")
        (label :text { "🔋 " + battery + "%" } :class "bat")))

    (defwidget clock-widget []
      (button :class "clock"
              :onclick "eww open --toggle control_center"
              time))

    ;; ------------------------------
    ;; Dropdown control center
    ;; ------------------------------

    (defwidget control []
      (box :orientation "v" :spacing 10 :class "control-center"
        (label :text { "🔊 Volume: " + volume + "%" })
        (label :text { " Wi-Fi: " + network })
        (label :text " Mic: on")
        (label :text time)))

    (defwindow bar
      :monitor 0
      :windowtype "dock"
      :exclusive true
      :geometry (geometry :x "0%" :y "0%" :width "100%" :height "30px" :anchor "top center")
      :reserve (struts :side "top" :distance "30px")
      (bar))

    (defwindow control_center
      :monitor 0
      :geometry (geometry :x "100%" :y "30px" :width "250px" :anchor "top right")
      :stacking "fg"
      (control))

    ;; ------------------------------
    ;; Polls for data
    ;; ------------------------------

    (defpoll time :interval "10s" "date '+%d/%m/%Y %H:%M'")
    (defpoll volume :interval "2s" "pamixer --get-volume")
    (defpoll network :interval "10s" "nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1==\"yes\"{print $2}' || echo 'offline'")
    (defpoll battery :interval "30s" "cat /sys/class/power_supply/BAT0/capacity || echo 100")
  '';

  home.file.".config/eww/eww.scss".text = ''
    * {
      font-family: JetBrainsMono Nerd Font, sans-serif;
      font-size: 13px;
    }
    
    // Working         
    .bar {
      background: #1e1e2e;
      color: #cdd6f4;
    }

    .workspaces button {
      background: #1e1e2e;   /* same as bar background */
      color: #cdd6f4;
      padding: 2px 6px;
      margin: 2px;
      border-radius: 5px;
      border: none;
      min-width: 24px;       /* smaller buttons */
    }

    .workspaces button:hover,
    .workspaces button:focus {
      background: #89b4fa;
      color: #1e1e2e;
    }

    .sysinfo {
      padding: 0 10px;
    }

    .clock {
      padding: 0 8px;
      background: transparent;
      border: none;
    }

    .control-center {
      background: #1e1e2e;
      color: #cdd6f4;
      padding: 10px;
      border-radius: 8px;
    }

    button {
      all: unset;            /* wipe GTK defaults */
      background: #1e1e2e;   /* same as bar */
      color: #cdd6f4;
      padding: 2px 8px;
      margin: 0 2px;
      border-radius: 5px;
    }

    button:hover {
      background: #89b4fa;
      color: #1e1e2e;
    }
  '';
}
