_: {
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "fr";
        kb_variant = "azerty";
      };
    };

    extraConfig = ''
      monitor = eDP-1, 1920x1080@60, 0x0, 1
      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
