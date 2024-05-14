{ config, pkgs, lib, ... }: {

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      neofetch
    '';
    shellAliases = {
      vi="vim";
      vim="nvim";
      ll="ls -al";
      neofetch="neofetch --ascii ~/.config/ascii-neofetch";
    };
  };
  
}
