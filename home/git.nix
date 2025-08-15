{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git # Distributed version control system
    gitflow # Extensions to Git for managing workflows
  ];

  programs.git = {
    enable = true;
    userName = "Pierre-Henri";
    userEmail = "phbasic@gmail.com";
  };
}

