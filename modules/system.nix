{ pkgs
, lib
, config
, ...
}:
let
  username = "ph";
  customAstronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut"; # list of options: astronaut, cyberpunk, hyprland_kath, etc.
  };
in
{

  environment = {
    systemPackages = with pkgs; [
      gnome-settings-daemon
      vim
      config.boot.kernelPackages.perf
      # Hyprland
      pamixer
      brightnessctl
      wl-clipboard
      udiskie
      networkmanagerapplet
      blueman
      hyprlock
      hypridle
      sddm-astronaut

      customAstronaut
    ];

    variables = {
      EDITOR = "nvim";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };
  };

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = {
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
  };

  networking.firewall.enable = false;

  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    settings = {
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [ username ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  powerManagement.cpuFreqGovernor = "performance";

  programs = {
    dconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    steam.enable = true;
    thunar.enable = true;
  };

  security = {
    pam.services.hyprlock = { };
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true; # ensures Wayland session
      package = pkgs.kdePackages.sddm; # force Qt6 build of SDDM
      theme = "sddm-astronaut-theme";
      extraPackages = [ customAstronaut pkgs.kdePackages.qtmultimedia ];
    };

    fprintd.enable = true;
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;

    logind.extraConfig = ''
      HandleLidSwitch=ignore
      HandleLidSwitchDocked=ignore
      IdleAction=ignore
    '';

    ollama.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    power-profiles-daemon.enable = true;
    printing.enable = true;

    pulseaudio.enable = false;

    tumbler.enable = true;
    udisks2.enable = true;

    xserver = {
      enable = true;
      desktopManager.gnome.enable = false;
      displayManager = {
        gdm.enable = false;
      };
    };

  };

  systemd = {
    services."set-performance-profile" = {
      description = "Set power profile to performance";
      after = [ "power-profiles-daemon.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance";
    };

    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };

  time.timeZone = "Europe/Paris";

  users.users.ph = {
    isNormalUser = true;
    description = "ph";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  virtualisation.docker.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "hyprland"; # Prefer Hyprland portal over GNOME
  };
}
