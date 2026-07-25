{self, ...}: {
  flake.nixosModules.headless = {pkgs, ...}: {
    imports = [
      self.nixosModules.nix
      self.nixosModules.shell
    ];
  };
}
