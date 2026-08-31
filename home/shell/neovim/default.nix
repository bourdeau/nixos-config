{pkgs, ...}: {
  home.file.".config/nvim".source = ./nvim;

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
    ];
  };
}
