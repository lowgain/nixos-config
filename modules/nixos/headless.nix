{self, ...}: {
  flake.nixosModules.headless = {
    imports = [
      self.nixosModules.nix
      self.nixosModules.shell
    ];
  };
}
