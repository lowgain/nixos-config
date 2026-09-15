{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.noctalia = {
    lib,
    options,
    ...
  }: {
    imports = [
      "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/noctalia.nix"
    ];
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
