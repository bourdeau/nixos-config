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
      
      (defvar workspaces "[1,2,3,4,5,6,7,8,9]")
      
      (defpoll active_workspace :interval "2s"
        "hyprctl activeworkspace | grep -oP '(?<=ID )\\d+'")

      (defwidget workspaces []
        (box :class "workspaces" :orientation "h" :spacing 5
          (for i in workspaces
            (button
              :class {i == active_workspace ? "active" : ""}
              :onclick "hyprctl dispatch workspace" + i
              i))))

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
    
    .bar {
      background: #1e1e2e;
      color: #cdd6f4;
    }

    .workspaces {
      margin-left: 6px; /* keep bar margin */
    }

    .workspaces button {
      all: unset;
      background: #1e1e2e;
      color: #cdd6f4;
      padding: 0px 0px;
      margin: 0 0px;
      border: 1px solid #cdd6f4;
      border-radius: 4px;
    }

    .workspaces button:hover,
    .workspaces button:focus {
      background: #89b4fa;
      color: #1e1e2e;
    }

    .workspaces button.active {
      background: #89b4fa;
      color: #1e1e2e;
      border: 1px solid #89b4fa;
    }
    .sysinfo {
      padding: 0;
    }

    .clock {
      padding: 0;
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
