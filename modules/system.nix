{ pkgs
, lib
, config
, ...
}:
let
  username = "ph";
in
{
  # --- Users ---
  users.users.ph = {
    isNormalUser = true;
    description = "ph";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Nix settings
  nix.settings.trusted-users = [ username ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    builders-use-substitutes = true;
  };

  # GC old generations
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree (Steam, etc.)
  nixpkgs.config.allowUnfree = true;

  # Locale / TZ
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # --- Display manager / desktops ---
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true; # Choose "Hyprland" at login
  services.xserver.desktopManager.gnome.enable = true; # Keep GNOME available

  # Hyprland session (system-provided wrapper)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # --- Graphics & audio stack ---
  hardware.graphics = { enable = true; enable32Bit = true; };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;

  # --- Portals (Wayland screenshare / file pickers) ---
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  # With GNOME installed, prefer the Hyprland portal to avoid conflicts:
  xdg.portal.config.common.default = "hyprland";

  # --- Polkit, keyring, storage (udiskie) ---
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;

  # --- Hyprlock + fingerprint ---
  services.fprintd.enable = true;
  security.pam.services.hyprlock = { };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # --- Power / sleep policies ---
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # GNOME-only idle tweaks (doesn't affect Hyprland)
  systemd.user.services."gnome-disable-idle" = {
    description = "Disable GNOME idle delay and screen blanking";
    serviceConfig.ExecStart = ''
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.session idle-delay 0
      ${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
      ${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
      ${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power critical-battery-action 'nothing'
      ${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power use-time-for-policy 'false'
    '';
    wantedBy = [ "default.target" ];
  };

  # --- Printing ---
  services.printing.enable = true;

  # --- Fonts ---
  fonts = {
    packages = with pkgs; [
      material-design-icons
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # --- Misc desktop plumbing ---
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  services.geoclue2.enable = true;

  # Hyprland mess
  services.dbus.enable = true;

  # --- Networking / firewall ---
  networking.firewall.enable = false;

  # --- Packages expected by your HM Hyprland config ---
  environment.systemPackages = with pkgs; [
    # your originals
    gnome-settings-daemon
    vim
    config.boot.kernelPackages.perf

    # for your Hyprland/HM bindings/services
    wofi
    pamixer
    brightnessctl
    wl-clipboard
    udiskie
    networkmanagerapplet
    blueman
    hyprlock
    hypridle
    # waybar
  ];

  programs.thunar.enable = true;
  # --- Env vars ---
  environment.variables = {
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # --- Containers / gaming / extras ---
  virtualisation.docker.enable = true;
  programs.steam.enable = true;
  services.ollama.enable = true;

  # --- Power profile ---
  services.power-profiles-daemon.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  systemd.services."set-performance-profile" = {
    description = "Set power profile to performance";
    after = [ "power-profiles-daemon.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
  };
}
