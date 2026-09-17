{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.frying-pan = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.fryingPanModule];
  };

  flake.nixosModules.fryingPanModule = {
    imports = [
      self.nixosModules.HomeManager
      self.nixosModules.lowgainModule
      self.nixosModules.nix
      self.nixosModules.plymouth
      self.nixosModules.desktop
      self.nixosModules.gaming
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.noctalia-greeter
      self.nixosModules.qemu
    ];

    hardware.facter = {
      enable = true;
      reportPath = ./facter.json;
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/3d3e5b01-bb5e-4025-b622-b38585ef5f36";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/53B6-D886";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/b0e652c7-6c0f-47be-aa8a-b414e77314c8";}
    ];

    time.timeZone = "America/Nassau";

    boot = {
      blacklistedKernelModules = ["i2c_smbus" "i2c_piix4"]; # Silence boot errors
      loader = {
        systemd-boot = {
          enable = true;
          memtest86.enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    networking = {
      hostName = "frying-pan";
      networkmanager.enable = true;
    };

    services = {
      openssh.enable = true;
      fwupd.enable = true;
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
