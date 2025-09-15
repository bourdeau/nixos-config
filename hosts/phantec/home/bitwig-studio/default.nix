{ pkgs, lib, ... }:

let
  bitwig-with-plugins = pkgs.buildFHSEnvBubblewrap {
    name = "bitwig-with-plugins";
    bubblewrap = pkgs.bubblewrap;

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

      # Audio backends
      pkgs.alsa-lib
      pkgs.pipewire
      pkgs.pulseaudio
    ];

    runScript = "bitwig-studio";

    # Make sure plugin hosts share the same FHS context
    extraInstallCommands = ''
      for host in BitwigPluginHost-X64-SSE41 BitwigPluginHost-X86-SSE41; do
        if [ -f ${pkgs.bitwig-studio}/libexec/bin/$host ]; then
          ln -s ${pkgs.bitwig-studio}/libexec/bin/$host $out/bin/$host
        fi
      done
    '';

    extraBindMounts = [
      "${pkgs.bubblewrap}/bin/bwrap:/usr/bin/bwrap"
    ];
  };
in
{
  home.packages = [
    bitwig-with-plugins
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
