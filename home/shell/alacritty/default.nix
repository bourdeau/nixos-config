{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = pkgs.lib.importTOML ./alacritty.toml;
  };
}
