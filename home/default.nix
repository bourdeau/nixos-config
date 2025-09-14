{
  imports = [
    ./bat
    ./btop
    ./gtk
    ./hyprland
    ./lazygit
    ./shell
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
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
