{self, ...}: {
  flake.nixosModules.shell = {
    options,
    lib,
    ...
  }: {
    config = lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [self.homeModules.shell];
    };
  };
}
