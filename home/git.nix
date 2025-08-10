{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git # Distributed version control system
    gitflow # Extensions to Git for managing workflows
    lazygit # Simple terminal UI for Git commands
  ];

  programs.git = {
    enable = true;
    userName = "Pierre-Henri";
    userEmail = "phbasic@gmail.com";
  };
}

