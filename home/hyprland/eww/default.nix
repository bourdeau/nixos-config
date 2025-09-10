{ pkgs, ... }:
{
  home.packages = with pkgs; [ eww ];

  home.file.".config/eww/eww.yuck".source = ./config/eww.yuck;
  home.file.".config/eww/eww.scss".source = ./config/eww.scss;
}
