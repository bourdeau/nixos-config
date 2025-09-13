{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
    package = null;
    portalPackage = null;
  };
  services = {
    hyprpolkitagent = {
      enable = true;
    };
    cliphist = {
      enable = true;
    };
    udiskie = {
      enable = true;
      automount = true;
      tray = "never";
    };
  };
}
