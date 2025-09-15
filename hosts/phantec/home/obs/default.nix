_: {
  programs.obs-studio.enable = true;

  hmCopyConfig = {
    obs-studio = {
      source = ./config;
      target = ".config/obs-studio";
    };
  };
}
