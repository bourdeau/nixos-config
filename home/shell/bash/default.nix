{ config, pkgs, lib, ... }: {

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      neofetch
    '';
    shellAliases = {
      vim="nvim";
      ll="ls -al";
      neofetch="neofetch --ascii ~/.config/ascii-neofetch";
    };
  };
  
}