{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.vmModule];
  };

  flake.nixosModules.vmModule = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.vmHardware
      self.nixosModules.myHomeManager
      self.nixosModules.lowgainModule
      self.nixosModules.niri
      self.nixosModules.nix
      self.nixosModules.shell
      self.nixosModules.desktop
      self.nixosModules.stylix
    ];

    time.timeZone = "America/Nassau";
    i18n.defaultLocale = "en_US.UTF-8";
    console.font = "Lat2-Terminus16";

    hardware = {
      graphics.enable = true;
      nvidia = {
        open = true;
        modesetting.enable = true;
      };
    };

    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          memtest86.enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    security = {
      sudo.wheelNeedsPassword = false;
      rtkit.enable = true;
    };

    networking = {
      hostName = "vm";
      networkmanager.enable = true;
    };

    home-manager = {
      sharedModules = [
        self.homeModules.shell
        self.homeModules.niri
        self.homeModules.desktop
        {
          programs.niri.settings = {
            outputs = {
              "Virtual-1" = {
                mode = {
                  width = 1600;
                  height = 900;
                  refresh = 60.000;
                };
                scale = 1.0;
              };
            };
            window-rules = [
              {
                matches = [{app-id = "dev.noctalia.Noctalia";}];
                open-floating = true;
                default-column-width = {fixed = 600;}; # display height
                default-window-height = {fixed = 200;}; # display width - 1000
              }
            ];
          };
        }
      ];
      users.lowgain = self.homeModules.lowgainModule;
    };

    services = {
      openssh.enable = true;
      xserver = {
        xkb.layout = "us";
        videoDrivers = ["nvidia"];
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
