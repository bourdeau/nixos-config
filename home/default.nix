{ config, pkgs, ... }:
{
  imports = [
    # Programs imports
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./monitoring.nix
    ./networking.nix
    ./programming.nix
    ./deconf.nix
    ./xdg.nix

    # Shell imports
    ./shell
  ];

  home = {
    username = "ph";
    homeDirectory = "/home/ph";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}

