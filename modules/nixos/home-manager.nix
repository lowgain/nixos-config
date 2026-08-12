{inputs, ...}: {
  flake.nixosModules.myHomeManager = {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
