{self, inputs, ...}: {
  flake.nixosConfigurations.fridge = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.fridgeModule];
  };

  flake.nixosModules.fridgeModule = {pkgs, lib, config, ...}: let
    kver = config.boot.kernelPackages.kernel.version;
  in {
    imports = [
      self.nixosModules.fridgeHardware
      self.nixosModules.nix
      self.nixosModules.home-manager
      self.nixosModules.stylix
    ];

    hardware = {
      cpu.amd.updateMicrocode = true;
      enableRedistributableFirmware = true;
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      xone.enable = true;
    }

    time.timeZone = "America/Nassau";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    boot = {
      kernelParams = [ "amd_pstate=active" "quiet" ];
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
      hostName = "fridge";
      networkmanager.enable = true;
    };

    users.users.lowgain = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
    };
    home-manager.users.lowgain = self.homeModules.lowgainModule;
  };
}
