{ config, ... }:
let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in
{
  imports = [
    ./nushell
    ./starship
    ./alacritty
    ./zellij
    ./bash
    ./neovim
  ];

  home.sessionVariables = {
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";
    EDITOR = "nvim";
    # BROWSER = "firefox";
    TERMINAL = "alacritty";
    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
  };

  home.shellAliases = {
    vim = "nvim";
  };
}
