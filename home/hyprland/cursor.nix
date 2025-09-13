{pkgs, ...}: {
  home.packages = [
    pkgs.catppuccin-cursors.mochaDark
  ];

  home.sessionVariables = {
    HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    HYPRCURSOR_SIZE = "24";
    XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    XCURSOR_SIZE = "24";
  };
}
