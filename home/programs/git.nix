{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "Pierre-Henri";
    userEmail = "phbasic@gmail.com";
  };
}