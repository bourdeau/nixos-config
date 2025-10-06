{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
  ];

  hmCopyConfig = {
    easyeffects = {
      source = ./config;
      target = ".config/easyeffects";
    };
  };
}
