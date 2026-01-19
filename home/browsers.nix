{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;

    languagePacks = ["en-US"];

    policies = {
      # Updates & Background Services
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      # Feature Disabling
      DisableBuiltinPDFViewer = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = true;
      DisableMasterPasswordCreation = false;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = false;
      DisablePasswordReveal = false;

      # Access Restrictions
      BlockAboutConfig = false;
      BlockAboutProfiles = true;
      BlockAboutSupport = true;

      # UI and Behavior
      DisplayMenuBar = "default-off";
      DisplayBookmarksToolbar = "always";
      DontCheckDefaultBrowser = true;
      HardwareAcceleration = true;
      OfferToSaveLogins = true;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";

      Homepage = {
        StartPage = "homepage"; # options: "none", "homepage", "previous-session"
        URL = "about:home";
        Locked = true;
      };

      Preferences = {
        "browser.compactmode.show".Value = true;
        "browser.uidensity".Value = 1; # 0=Normal, 1=Compact, 2=Touch
        "browser.newtabpage.enabled".Value = true; # show the default Firefox new tab
        "browser.newtabpage.override".Value = "about:newtab";
        "browser.newtabpage.override.on".Value = true;
        "extensions.activeThemeID".Status = "locked";
        "extensions.activeThemeID".Value = "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}";
      };

      # Extensions
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".allowed_types = ["dictionary" "locale" "theme"];
        "*".install_sources = ["https://addons.mozilla.org/*"];

        "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}" = {
          install_url = moz "catppuccin-mocha-blue-git";
          installation_mode = "force_installed";
          updates_disabled = false;
        };

        "fr-dicollecte@dictionaries.addons.mozilla.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dictionnaire-fran%C3%A7ais1/latest.xpi";
          installation_mode = "force_installed";
          updates_disabled = true;
        };

        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled = true;
        };

        "3rdparty".Extensions = {
          "uBlock0@raymondhill.net".adminSettings = {
            userSettings = rec {
              uiTheme = "dark";
              uiAccentCustom = true;
              uiAccentCustom0 = "#8300ff";
              cloudStorageEnabled = lib.mkForce false;

              importedLists = [
                "https://filters.adtidy.org/extension/ublock/filters/3.txt"
                "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              ];

              externalLists = lib.concatStringsSep "\n" importedLists;
            };

            selectedFilterLists = [
              "CZE-0"
              "adguard-generic"
              "adguard-annoyance"
              "adguard-social"
              "adguard-spyware-url"
              "easylist"
              "easyprivacy"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              "plowe-0"
              "ublock-abuse"
              "ublock-badware"
              "ublock-filters"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "urlhaus-1"
            ];
          };
        };
        "sponsorBlocker@ajay.app" = {
          install_url = moz "sponsorblock";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
      };
    };

    profiles.default.search = {
      force = true;
      default = "ddg";
      # privateDefault = "SearX (canine.tools)";

      engines = {
        # Disable built-in engines
        "google".metaData.hidden = true;
        "bing".metaData.hidden = true;
        "qwant".metaData.hidden = true;
        "wikipedia".metaData.hidden = true;
        # Let's try it
        "ddg".metaData.hidden = false;
        "perplexity".metaData.hidden = false;

        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };

        "Nix Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@no"];
        };

        "NixOS Wiki" = {
          urls = [
            {
              template = "https://wiki.nixos.org/w/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@nw"];
        };
      };
    };
  };
}
