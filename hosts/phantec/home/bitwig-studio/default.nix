{pkgs, ...}: let
  # Wrap Bitwig Studio inside a FHS-compatible environment (bubblewrap sandbox).
  # This is needed because Bitwig loads VST plugins, which are precompiled binaries
  # expecting the "standard Linux filesystem layout" and dynamic libraries to be in
  # /usr/lib-style locations. NixOS doesn’t provide that by default.
  bitwig-with-plugins = pkgs.buildFHSEnvBubblewrap {
    name = "bitwig-with-plugins";

    # targetPkgs = the packages available inside the FHS environment.
    # Here we include:
    # - Bitwig itself
    # - lsp-plugins (test case for plugins)
    # - all libraries required by the plugins (libsndfile, cairo, X11, GL, etc.)
    targetPkgs = pkgs: [
      pkgs.bitwig-studio
      pkgs.lsp-plugins

      pkgs.libsndfile # needed by many audio plugins
      pkgs.cairo # graphics/text rendering dependency
      pkgs.fontconfig.lib
      pkgs.freetype
      pkgs.libGL
      pkgs.xorg.libX11
      pkgs.xorg.libXrandr
      pkgs.stdenv.cc.cc.lib # provides libstdc++.so for C++ plugins
    ];

    runScript = "bitwig-studio";
  };
in {
  # Make our wrapper available in PATH so we can run "bitwig-with-plugins"
  home.packages = [
    bitwig-with-plugins
  ];

  # Override Bitwig’s default .desktop file, because the stock one launches
  # plain `bitwig-studio`, which doesn’t have working VSTs on NixOS.
  # Instead, we point Exec= to our wrapped version.
  home.file.".local/share/applications/com.bitwig.BitwigStudio.desktop".text = ''
    [Desktop Entry]
    Name=Bitwig Studio
    GenericName=Digital Audio Workstation
    Comment=Bitwig Studio with working VST plugins
    Exec=${bitwig-with-plugins}/bin/bitwig-with-plugins %F
    Icon=com.bitwig.BitwigStudio
    Terminal=false
    Type=Application
    Categories=AudioVideo;Audio;Midi;Sequencer;
    StartupWMClass=com.bitwig.BitwigStudio
    MimeType=application/bitwig-project;application/bitwig-preset;
  '';
}
