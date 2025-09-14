{pkgs, ...}: {
  home.packages = with pkgs; [
    pavucontrol
    playerctl
    pulsemixer
    imv
    audacity
    easyeffects
    gimp
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
