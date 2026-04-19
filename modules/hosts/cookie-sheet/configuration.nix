{
    self,
    inputs,
    ...
}: {
    flake.nixosConfigurations.cookieSheet = inputs.nixpkgs.lib.nixosSystem {
        modules = [ self.nixosModules.cookieSheetfig ];
    };

    flake.nixosModules.cookieSheetfig = {pkgs, ...}: {
        imports = [
            self.nixosModules.cookieSheetware
            self.nixosModules.nix
            self.nixosModules.desktop
            self.nixosModules.shell

            # inputs.disko.flakeModules.default
            # self.diskoConfigurations.cookieSheet
        ];

        # Use the systemd-boot EFI boot loader.
        boot = {
            kernelPackages = pkgs.linuxKernel.packages.linux_zen;
            kernelParams = [ "quiet" ];

            loader.systemd-boot = {
                enable = true;
                memtest86.enable = true;
            };
            loader.efi.canTouchEfiVariables = true;
        };

        networking.hostName = "cookie-sheet"; # Define your hostname.

        # Enable Wifi
        # Configure network connections interactively with nmcli or nmtui.
        networking.networkmanager.enable = true;

        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
        };

        time.timeZone = "America/Nassau";

        # Enable touchpad support
        services.libinput.enable = true;

        # SHTF Packages
        environment.systemPackages = with pkgs; [
            vim
            wget
        ];

        programs.ssh = {
            # startAgent = true;
            extraConfig = ''
                AddKeysToAgent yes
            '';
        };

        services.openssh = {
            enable = true;
            settings.PermitRootLogin = "no";
        };

        # Autologin dispay manager to avoid double login
        # services.displayManager.autoLogin.enable = true;
        # services.displayManager.autoLogin.user = "${self.name}";

        hardware = {
            cpu.amd.updateMicrocode = true;
            enableAllFirmware = true;
            enableAllHardware = true;
        };

        services.upower.enable = true;
        powerManagement.powertop.enable = true;
        services.thermald.enable = true;

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
