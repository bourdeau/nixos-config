{config, ...}: let
  browser = ["firefox.desktop"];
  viewer = ["imv.desktop"];

  associations = {
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;
    "image/jpeg" = viewer;
    "image/png" = viewer;
    "image/gif" = viewer;
    "image/webp" = viewer;
    "image/svg+xml" = viewer;
    "image/tiff" = viewer;
    "image/bmp" = viewer;
    "application/json" = browser;
    "text/x-csharp" = [
      "vim.desktop"
      "nvim.desktop"
    ];
    "application/pdf" = ["org.pwmt.zathura.desktop"];
  };
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
  };
}
