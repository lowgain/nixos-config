{inputs, ...}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.mangowm.nixosModules.mango
  ];
}
