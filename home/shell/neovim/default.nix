{ config, pkgs, ... }:
{
  home.file.".config/nvim".source = ./nvim;

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
    ];
  };
}

