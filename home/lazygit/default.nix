{
  programs.lazygit.enable = true;

  home.file = {
    ".config/lazygit/config.yaml".source = ./config.yml;
  };
}
