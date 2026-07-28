{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.fridge = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.fridgeModule];
  };

  flake.nixosModules.fridgeModule = {pkgs, ...}: {
    imports = [
      self.nixosModules.fridgeHardware
      self.nixosModules.desktop
      self.nixosModules.myHomeManager
      self.nixosModules.lowgainModule
      # self.nixosModules.avahi
    ];

    hardware = {
      # cpu.amd.updateMicrocode = true;

      # nvidia = {
      #   package = config.boot.kernelPackages.nvidiaPackages.stable;
      #   modesetting.enable = true;
      #   open = true;
      #   nvidiaSettings = true;
      # };

      # bluetooth = {
      #   enable = true;
      #   powerOnBoot = true;
      # };

      # xone.enable = true;

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    time.timeZone = "America/Nassau";
    i18n.defaultLocale = "en_US.UTF-8";
    console.font = "Lat2-Terminus16";

    boot = {
      # kernelParams = ["amd_pstate=active" "quiet" "nvidia-drm.modeset=1"];
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

    # environment.systemPackages = with pkgs; [
      # heroic
      # mangohud
    # ];

    home-manager = {
      sharedModules = [
        # self.homeModules.desktop
      ];
      users.lowgain = self.homeModules.lowgainModule;
    };

    services = {
      openssh.enable = true;
    #   xserver.videoDrivers = ["nvidia"];
      xserver.xkb.layout = "us";
    };

    # programs = {
    #   steam = {
    #     enable = true;
    #     remotePlay.openFirewall = true;
    #     protontricks.enable = true;
    #   };

    #   gamemode.enable = true;
    # };

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
