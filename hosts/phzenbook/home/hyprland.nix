_: {
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "fr";
        kb_variant = "azerty";
      };
    };
    extraConfig = ''
      monitor = eDP-1, 3840x2160@30, 0x0, 1.0
      xwayland {
        force_zero_scaling = true
      }
    '';
  };
}
