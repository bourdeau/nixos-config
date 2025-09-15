{
  lib,
  pkgs,
  config,
  ...
}: {
  options.hmCopyConfig = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        source = lib.mkOption {
          type = lib.types.path;
          description = "Source directory to copy from.";
        };
        target = lib.mkOption {
          type = lib.types.str;
          description = "Target directory (relative to $HOME or absolute).";
        };
      };
    });
    default = {};
    description = "Configs to copy anywhere in $HOME with rsync at activation.";
  };

  config = {
    home.activation.copyConfigs = lib.hm.dag.entryAfter ["writeBoundary"] (
      lib.concatStringsSep "\n" (
        lib.mapAttrsToList
        (_: cfg: ''
          ${pkgs.rsync}/bin/rsync -avz --delete --chmod=D2755,F744 \
            ${cfg.source}/ \
            ${lib.escapeShellArg (
            if lib.hasPrefix "/" cfg.target
            then cfg.target
            else "${config.home.homeDirectory}/${cfg.target}"
          )}/
        '')
        config.hmCopyConfig
      )
    );
  };
}
