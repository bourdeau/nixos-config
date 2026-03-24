{
  imports = [
    ./bat
    ./btop
    ./gtk
    ./hyprland
    ./k9s
    ./lazygit
    ./shell
    ./ssh
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./media.nix
    ./monitoring.nix
    ./networking.nix
    ./programming.nix
    ./xdg.nix
  ];

  home = {
    username = "ph";
    homeDirectory = "/home/ph";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
