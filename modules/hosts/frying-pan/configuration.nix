{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.frying-pan = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.fryingPanModule];
  };

  flake.nixosModules.fryingPanModule = {pkgs, ...}: {
    imports = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.fryingPan
      self.nixosModules.nix
      self.nixosModules.plymouth
      self.nixosModules.preservation
      self.nixosModules.neovim
      self.nixosModules.HomeManager
      self.nixosModules.lowgainModule
      self.nixosModules.desktop
      self.nixosModules.gaming
      self.nixosModules.niri
      self.nixosModules.noctalia
    ];

    hardware.facter = {
      enable = true;
      reportPath = ./facter.json;
    };

    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    time.timeZone = "America/Nassau";

    networking = {
      hostName = "frying-pan";
      networkmanager.enable = true;
    };

    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    services = {
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.niri}/bin/niri-session";
            user = "lowgain";
          };
          default_session = initial_session;
        };
      };
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
