{pkgs, ...}: {
  imports = [
    ../../../modules/hm-copy-config.nix
    ./bitwig-studio
    ./easyeffects
    ./obs
    ./shotcut
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    steam # Steam client
    # protonup-qt # Manage custom Proton-GE builds
    # lutris # Game manager for non-Steam games (Battle.net, GOG, emulators…)
    # heroic # Epic Games Store & GOG launcher
    # bottles # Manage Wine prefixes ("bottles") for games/apps
  ];
}
