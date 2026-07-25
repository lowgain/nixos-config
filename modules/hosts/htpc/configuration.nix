{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.htpc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.htpcModule
    ];
  };

  flake.nixosModules.htpcModule = {config, pkgs, ...}: {
    imports = [
      self.nixosModules.htpcHardware
      self.nixosModules.nix
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
      enableRedistributableFirmware = true;
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      xone.enable = true;
    };

    security = {
      sudo.wheelNeedsPassword = false;
      rtkit.enable = true;
    };

    time.timeZone = "America/Nassau";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    boot = {
      kernelParams = [ "quiet" ];
      consoleLogLevel = 0;
      initrd.verbose = false;
      loader = {
        timeout = 1;
        systemd-boot = {
          enable = true;
          memtest86.enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    networking = {
      hostName = "htpc";
      networkmanager.enable = true;
    };

    users.users.htpc = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
    };

    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    services = {

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
      };

      xserver.xkb.layout = "us";

      libinput.enable = true;

      openssh.enable = true;

      cage = {
        enable = true;
        user = "htpc";
        program = "${(pkgs.kodi-wayland.withPackages (kodiPkgs: with kodiPkgs; [
          joystick
          youtube
          sponsorblock
        ]))}/bin/kodi-standalone";
      };

      qbittorrent = {
        enable = true;
        user = "htpc";
        group = "users";
        openFirewall = true;
        webuiPort = 8081;
        serverConfig = {
          LegalNotice.Accepted = true;
          BitTorrent = {
            Session = {
              AnonymousModeEnabled = true;
              Interface = "wlp2s0";
              InterfaceAddress = "0.0.0.0";
              InterfaceName = "wlp2s0";
            };
          };
          Preferences = {
            General = {
              Locale = "en";
              StatusbarExternalIPDisplayed = true;
              StatusbarFreeDiskSpaceDisplayed = true;
            };
            Search.SearchEnabled = true;
            WebUI = {
              AlternativeUIEnabled = true;
              RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
              AuthSubnetWhitelistEnabled = true;
              Enabled = true;
              LocalHostAuth = false;
              Password_PBKDF2 = "qx5uY4bYgyOqlHWiuWPRCw==:j+g6ZaRv4Tf37KUwU1VMbTQlxAsginw9NUeM37f5So+y/SUTjLogk4uL+uflXu/uoO6xDEm25nHydmBCdQvOUA==";
            };
          };
          IPSubnetWhitelistOptionsDialog = {
            Size = "@Size(360 450)";
          };
          AddNewTorrentDialog = {
            RememberLastSavePath = true;
            SavePathHistory = "/home/htpc/Downloads";
          };
        };
      };
    };

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}
