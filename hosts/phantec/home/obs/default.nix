{config, ...}: {
  programs.obs-studio.enable = true;

  # I use custom helper to rsync files, because OBS needs to read/write into .configs
  # so home.file won' t make it.
  hmCopyDir = {
    obs-studio = {
      source = ./config;
      target = "${config.xdg.configHome}/obs-studio";
    };
  };
}
