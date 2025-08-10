{ lib
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    pavucontrol
    playerctl
    pulsemixer
    imv
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };

    obs-studio.enable = true;
  };

  services = {
    playerctld.enable = true;
  };
}

