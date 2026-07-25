{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.wslModule];
  };

  flake.nixosModules.wslModule = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.nix
      self.nixosModules.headless
      self.nixosModules.stylix
      self.nixosModules.myHomeManager
      self.nixosModules.lowgainModule
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    time.timeZone = "America/Nassau";

    wsl = {
      enable = true;
      defaultUser = "lowgain";
      startMenuLaunchers = true;
      usbip.enable = true;
      useWindowsDriver = true;
      ssh-agent.enable = true;
    };

    home-manager = {
      sharedModules = [
        self.homeModules.shell
      ];
      users.lowgain = self.homeModules.lowgainModule;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}
