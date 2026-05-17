{inputs, ...}: {
  flake.nixosModules.browsers = {pkgs, ...}: let
    extension = shortId: guid: {
      name = guid;
      value = {
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "normal_installed";
      };
    };

    prefs = {
      # Check these out at about:config
      "extensions.autoDisableScopes" = 0;
      "extensions.pocket.enabled" = false;
      # ...
    };

    extensions = [
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
      (extension "ublock-origin" "uBlock0@raymondhill.net")
      # ...
    ];
  in {
    programs = {
      ladybird.enable = true;
      chromium = {
        enable = true;
        extensions = [
          "fdjamakpfbbddfjaooikfcpapjohcfmg" # Dashlane
        ];
        homepageLocation = "https://duckduckgo.com/";
        defaultSearchProviderEnabled = true;
        defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
        defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
      };
    };

    environment.systemPackages = with pkgs; [
      chromium
      (
        pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
            )
            prefs
          );

          extraPolicies = {
            DisableTelemetry = true;
            ExtensionSettings = builtins.listToAttrs extensions;

            SearchEngines = {
              Default = "@b";
              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "Brave";
                  URLTemplate = "https://search.brave.com/search?q={searchTerms}";
                  IconURL = "https://search.brave.com/favicon.ico";
                  Alias = "@b";
                }
                {
                  Name = "Youtube";
                  URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                  IconURL = "https://youtube.com/favicon.ico";
                  Alias = "@y";
                }
              ];
            };
          };
        }
      )
    ];
  };
}
