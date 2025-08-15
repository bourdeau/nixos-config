{ lib, pkgs, ... }:

{
  programs.btop.enable = true;

  home.file = {
    ".config/btop/btop.conf".source = ./btop.conf;
    ".config/btop/themes/catppuccin_mocha.theme".source = ./themes/catppuccin_mocha.theme;
  };
}
