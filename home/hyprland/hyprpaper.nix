# Not working
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/ph/Images/wallpapers/1.jpg
    wallpaper = HDMI-A-2,/home/ph/Images/wallpapers/1.jpg
  '';
}
