{config, ...}: {
  programs.k9s.enable = true;

  home.file.".config/k9s/config.yaml".text = ''
    k9s:
      liveViewAutoRefresh: false
      screenDumpDir: "${config.xdg.stateHome}/k9s/screen-dumps"
      refreshRate: 2
      apiServerTimeout: 15s
      maxConnRetry: 5
      readOnly: false
      noExitOnCtrlC: false
      portForwardAddress: localhost
      ui:
        skin: catppuccin-mocha
        enableMouse: false
        headless: false
        logoless: false
        crumbsless: false
        splashless: false
        reactive: false
        noIcons: false
        defaultsToFullScreen: false
        useFullGVRTitle: false
      skipLatestRevCheck: false
      disablePodCounting: false
      shellPod:
        image: busybox:1.35.0
        namespace: default
        limits:
          cpu: 100m
          memory: 100Mi
      imageScans:
        enable: false
        exclusions:
          namespaces: []
          labels: {}
      logger:
        tail: 100
        buffer: 5000
        sinceSeconds: -1
        textWrap: false
        disableAutoscroll: false
        showTime: false
      thresholds:
        cpu:
          critical: 90
          warn: 70
        memory:
          critical: 90
          warn: 70
      defaultView: ""
  '';

  home.file.".config/k9s/skins/catppuccin-mocha.yaml".source = ./skins/catppuccin-mocha.yaml;
}
