{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.vmModule];
  };

  flake.nixosModules.vmModule = {lib, ...}: {
    imports = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.vm
      self.nixosModules.preservation
    ];

    hardware.facter = {
      enable = true;
      reportPath = ./facter.json;
    };

    boot.loader.grub = {
      enable = true;
      efiSupport = lib.mkDefault true;
      efiInstallAsRemovable = lib.mkDefault true;
    };

    system.stateVersion = "26.05";
    users.users.lowgain = {
      isNormalUser = true;
      initialPassword = "Lowgain";
      extraGroups = ["wheel"];
    };
    services.openssh.enable = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
