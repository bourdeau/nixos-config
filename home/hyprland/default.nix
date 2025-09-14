{pkgs, ...}: {
  imports = [
    ./hyprpaper
    ./swaync
    ./waybar
    ./wofi
    ./config.nix
    ./cursor.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./variables.nix
  ];

  home.packages = with pkgs; [
    gnome.gvfs
    uwsm
    hyprshot
  ];
}
