{
  pkgs,
  lib,
  ...
}: let
  # We create a wrapper around Bitwig Studio using buildFHSEnvBubblewrap.
  # This provides a FHS-like environment, so that plugins and Bitwig’s
  # plugin host can find shared libraries (like libsndfile, freetype, X11, etc.)
  # at the paths they expect.
  bitwig-with-plugins = pkgs.buildFHSEnvBubblewrap {
    name = "bitwig-with-plugins";
    inherit (pkgs) bubblewrap;

    # Packages that need to exist in the FHS environment.
    # These include:
    # - Bitwig itself
    # - LSP Plugins (example VST plugins)
    # - Runtime dependencies that plugins/Bitwig expect dynamically
    # - Audio backend libraries
    targetPkgs = pkgs: [
      pkgs.bitwig-studio
      pkgs.lsp-plugins

      # Runtime deps for LSP and graphics
      pkgs.libsndfile
      pkgs.cairo
      pkgs.fontconfig.lib
      pkgs.freetype
      pkgs.libGL
      pkgs.xorg.libX11
      pkgs.xorg.libXrandr
      pkgs.stdenv.cc.cc.lib

      # Audio backends so Bitwig and plugins can talk to ALSA/Pipewire/Pulse
      pkgs.alsa-lib
      pkgs.pipewire
      pkgs.pulseaudio
    ];

    # Entry point: when you run "bitwig-with-plugins", it runs Bitwig Studio
    runScript = "bitwig-studio";

    # Make sure Bitwig’s plugin hosts (the processes that actually run VSTs)
    # are available inside the wrapper as well, otherwise Bitwig can launch
    # but plugins will fail or freeze.
    extraInstallCommands = ''
      for host in BitwigPluginHost-X64-SSE41 BitwigPluginHost-X86-SSE41; do
        if [ -f ${pkgs.bitwig-studio}/libexec/bin/$host ]; then
          ln -s ${pkgs.bitwig-studio}/libexec/bin/$host $out/bin/$host
        fi
      done
    '';

    # Ensure `bwrap` itself is available inside the container
    # (sometimes Bitwig or plugins try to spawn it).
    extraBindMounts = [
      "${pkgs.bubblewrap}/bin/bwrap:/usr/bin/bwrap"
    ];
  };
in {
  home.packages = [
    bitwig-with-plugins # Add our wrapper to PATH
  ];

  # Override desktop entry to point to wrapper
  home.file.".local/share/applications/com.bitwig.BitwigStudio.desktop".text = ''
    [Desktop Entry]
    Name=Bitwig Studio
    GenericName=Digital Audio Workstation
    Comment=Bitwig Studio with working VST plugins
    Exec=bitwig-with-plugins %F
    Icon=com.bitwig.BitwigStudio
    Terminal=false
    Type=Application
    Categories=AudioVideo;Audio;Midi;Sequencer;
    StartupWMClass=com.bitwig.BitwigStudio
    MimeType=application/bitwig-project;application/bitwig-preset;
  '';
}
