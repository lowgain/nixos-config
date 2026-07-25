{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.fridge = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.fridgeModule];
  };

  flake.nixosModules.fridgeModule = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.fridgeHardware
      self.nixosModules.nix
      self.nixosModules.stylix
      self.nixosModules.niri
      self.nixosModules.myHomeManager
      self.nixosModules.lowgainModule
    ];

    hardware = {
      cpu.amd.updateMicrocode = true;

      enableRedistributableFirmware = true;

      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
      };

      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      xone.enable = true;

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    time.timeZone = "America/Nassau";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
    };

    boot = {
      kernelParams = ["amd_pstate=active" "quiet" "nvidia-drm.modeset=1"];
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

    environment.systemPackages = with pkgs; [
      wget
      vim
      heroic
      mangohud
    ];

    home-manager = {
      sharedModules = [
        self.homeModules.shell
        self.homeModules.noctalia
      ];
      users.lowgain = self.homeModules.lowgainModule;
    };

    services = {
      xserver.videoDrivers = ["nvidia"];
    };

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        protonTricks.enable = true;
      };

      gamemode.enable = true;
    };
  };
}
