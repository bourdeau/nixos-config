{ lib, pkgs, config, ... }:

# Helper function to rsync a config directory into XDG config
# Example usage:
#   hmCopyConfig "obs-studio" ./config
#   hmCopyConfig "nvim" ./nvim
# It is useful for pkgs that need read and write in their .config directory
#
{
  options.hmCopyConfig = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
    default = { };
    description = "Configs to copy into XDG config with rsync at activation.";
  };

  config = {
    home.activation.copyConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] (
      lib.concatStringsSep "\n" (
        lib.mapAttrsToList
          (name: path: ''
            ${pkgs.rsync}/bin/rsync -avz --delete --chmod=D2755,F744 ${path}/ ${config.xdg.configHome}/${name}/
          '')
          config.hmCopyConfig
      )
    );
  };
}
