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
      tf="terraform";
      neofetch="neofetch --ascii ~/.config/ascii-neofetch";
    };
  };
  
}
