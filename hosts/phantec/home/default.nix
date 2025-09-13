{ config, pkgs, ... }:
{
  imports = [
    ../../../modules/hm-copy-config.nix
    ./obs
  ];
}

