_: {
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    # Disable hardware cursors (avoids cursor corruption & freezes)
    WLR_NO_HARDWARE_CURSORS = "1";
    # Required for EGLStream path (NVIDIA < GBM default)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };
}
