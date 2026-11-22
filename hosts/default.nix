{ inputs, ...}: {
  frying-pan = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      ./frying-pan/configuration.nix
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default
      inputs.hjem.nixosModules.default
      ../users/lowgain
    ];
  };
}
