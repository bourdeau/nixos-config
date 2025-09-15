{
  lib,
  pkgs,
  config,
  ...
}: {
  options.hmCopyDir = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        source = lib.mkOption {type = lib.types.path;};
        target = lib.mkOption {type = lib.types.str;};
      };
    });
    default = {};
    description = "Copy arbitrary directories with rsync at activation.";
  };

  config = {
    home.activation.copyDirs = lib.hm.dag.entryAfter ["writeBoundary"] (
      lib.concatStringsSep "\n" (
        lib.mapAttrsToList
        (_: {
          source,
          target,
        }: ''
          ${pkgs.rsync}/bin/rsync -avz --delete --chmod=D2755,F744 ${source}/ ${target}/
        '')
        config.hmCopyDir
      )
    );
  };
}
