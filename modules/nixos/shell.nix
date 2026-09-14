{self, ...}: {
  flake.nixosModules.shell = {
    options,
    lib,
    ...
  }: {
    config = lib.optionalAttrs (options ? home-manager) {
      home-modules.sharedModules = [self.homeModules.shell];
    };
  };
}
