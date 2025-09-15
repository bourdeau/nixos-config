{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwig-studio
  ];

  hmCopyConfig = {
    bitwig-prefs = {
      source = ./config/prefs;
      target = ".BitwigStudio/prefs";
    };

    bitwig-view-settings = {
      source = ./config/view-settings;
      target = ".BitwigStudio/view-settings";
    };

    bitwig-color-palettes = {
      source = ./config/Color_Palettes;
      target = "Bitwig_Studio/Color_Palettes";
    };

    bitwig-controller-scripts = {
      source = ./config/Controller_Scripts;
      target = "Bitwig_Studio/Controller_Scripts";
    };
  };
}
