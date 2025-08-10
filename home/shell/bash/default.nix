{ config, pkgs, lib, ... }: {

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      vi="vim";
      vim="nvim";
      ll="ls -al";
      tf="terraform";
    };
  };
  
}
