{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.wslModule
      self.nixosModules.myHomeManager
      self.nixosModules.stylix
      inputs.nixos-wsl.nixosModules.default
    ];
  };

  flake.nixosModules.wslModule = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.nix
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    time.timeZone = "America/Nassau";

    users.users.lowgain = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
    home-manager.users.lowgain = self.homeModules.lowgainModule;

    environment.systemPackages = with pkgs; [
      wget
      curl
      tree
      btop
      vim
    ];

    wsl = {
      enable = true;
      defaultUser = "lowgain";
      startMenuLaunchers = true;
      usbip.enable = true;
      useWindowsDriver = true;
      ssh-agent.enable = true;
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
