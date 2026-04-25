{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.cookieSheet = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.cookieSheetfig];
  };

  flake.nixosModules.cookieSheetfig = {pkgs, ...}: {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
      inputs.nixos-hardware.nixosModules.common-gpu-amd
      inputs.nixos-hardware.nixosModules.common-pc
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      self.nixosModules.cookieSheetware
      self.nixosModules.nix
      self.nixosModules.desktop
      self.nixosModules.shell
    ];

    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      kernelParams = ["quiet" "loglevel=3"];
      blacklistedKernelModules = ["i2c_smbus" "i2c_piix4"]; # Makes startup errors

      loader.systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 10;
      };
      loader.efi.canTouchEfiVariables = true;
    };

    networking = {
      hostName = "cookie-sheet";
      networkmanager.enable = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    time.timeZone = "America/Nassau";

    services.libinput.enable = true;

    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";
      HandleSuspendKey = "ignore";
      HandleSuspendKeyLongPress = "suspend";
    };

    programs.ssh = {
      extraConfig = ''
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_ed25519
      '';
    };

    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    # Autologin dispay manager to avoid double login
    # services.displayManager.autoLogin = {
    #   enable = true;
    #   user = "${self.name}";
    # };

    services.thermald.enable = true;

    services.upower.enable = true;

    powerManagement.powertop.enable = true;

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
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
