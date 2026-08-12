{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.htpc = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.htpcModule];
  };

  flake.nixosModules.htpcModule = {pkgs, ...}: {
    imports = [
      self.nixosModules.htpcHardware
      self.nixosModules.headless
      self.nixosModules.avahi
    ];

    hardware = {
      cpu.intel.updateMicrocode = true;
      enableRedistributableFirmware = true;
      xone.enable = true;
      graphics.extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
      ];
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      alsa = {
        enable = true;
        enableBluetooth = true;
        plugins = [pkgs.bluez-alsa];
        config = ''
          default.bluealsa {
            profile "a2dp"
            interface "hci0"
            device "F8:5C:7E:1F:97:2A"
          }
          pcm.!default {
            type plug
            slave.pcm {
              type bluealsa
              device "F8:5C:7E:1F:97:2A"
              profile "a2dp"
            }
            hint {
              show on
              description "Logans Charge 5"
            }
          }
          ctl.!default {
            type bluealsa
            device "F8:5C:7E:1F:97:2A"
          }
        '';
      };
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
      kernelParams = ["quiet"];
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

    users = {
      users.admin = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMjw3UlPY0SebTuJ2/tDl1IMcOeJP7pBdGU29IVRbfyB logan.t2020@tutanota.com"
        ];
      };
      extraUsers.kodi = {
        isNormalUser = true;
        extraGroups = ["audio" "bluetooth"];
      };
    };

    services = {
      xserver.xkb.layout = "us";

      libinput.enable = true;

      openssh.enable = true;

      cage = {
        enable = true;
        user = "kodi";
        program = "${(pkgs.kodi-wayland.withPackages (kodiPkgs:
          with kodiPkgs; [
            joystick
            youtube
            sponsorblock
            bluetooth-manager
            somafm
            trakt
            upnext
          ]))}/bin/kodi-standalone";
      };

      qbittorrent = {
        enable = true;
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
            General.Locale = "en";
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
          IPSubnetWhitelistOptionsDialog.Size = "@Size(360 450)";
          AddNewTorrentDialog = {
            RememberLastSavePath = true;
            SavePathHistory = "/srv/media";
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
