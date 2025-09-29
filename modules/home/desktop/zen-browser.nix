{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
in {
  imports = [inputs.zen-browser.homeModules.beta];

  stylix.targets.zen-browser.profileNames = ["default"];

  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      isDefault = true;
      search = {
        default = "br";
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
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

          nix-options = {
            name = "Nix Options";
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "options";
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

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = ["@nw"];
          };

          brave-search = {
            name = "Brave Search";
            urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
            iconMapObj."16" = "https://brave.com/favicon.ico";
            definedAliases = [
              "@br"
              "@brave"
            ];
          };
        };
      };
    };
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Extensions = {
        Install = [
          "https://addons.mozilla.org/firefox/downloads/file/4573289/ublock_origin-1.66.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4535824/darkreader-4.9.110.xpi"
        ];
      };
    };
  };
}
