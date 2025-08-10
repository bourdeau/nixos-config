{ config, pkgs, ... }:

let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in
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
    ./nushell
    ./starship
    ./alacritty
    ./zellij
    ./bash
    ./neovim
  ];

  home = {
    username = "ph";
    homeDirectory = "/home/ph";

    stateVersion = "24.11";

    sessionVariables = {
      LESSHISTFILE = cache + "/less/history";
      LESSKEY = c + "/less/lesskey";
      WINEPREFIX = d + "/wine";

      EDITOR = "vim";
      # BROWSER = "firefox";
      TERMINAL = "alacritty";

      DELTA_PAGER = "less -R";
    };

    shellAliases = {
      vim = "nvim";
    };
  };

  programs.home-manager.enable = true;
}

