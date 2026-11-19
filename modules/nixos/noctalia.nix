{
  self,
  ...
}: {
  flake.nixosModules.noctalia = {
    lib,
    options,
    ...
  }: {
    config = lib.mkMerge [
      {
        programs.noctalia = {
          enable = true;
          recommendedServices.enable = true;
        };
      }
      (lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [self.homeModules.noctalia];
      })
    ];
  };
}
