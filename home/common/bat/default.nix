{ lib, pkgs, ... }:

{
  programs.bat.enable = true;

  home.file = {
    ".config/bat/themes/catppuccin_mocha.tmTheme".source = ./themes/catppuccin_mocha.tmTheme;
  };

  programs.bat.config = {
    italic-text = "always";
    map-syntax = [
      "*.ino:C++"
      ".ignore:Git Ignore"
    ];
    theme = "catppuccin_mocha";
  };
}
