_: {
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "intl";
        kb_options = "lv3:caps_switch";
      };
    };

    extraConfig = ''
      monitor = HDMI-A-2, 3840x2160@240, 0x0, 1
      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
