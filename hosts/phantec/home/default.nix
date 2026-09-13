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
    steam
    steamcmd
  ];
}
