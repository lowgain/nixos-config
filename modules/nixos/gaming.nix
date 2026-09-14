{self, ...}: {
  flake.nixosModules.gaming = {
    pkgs,
    lib,
    options,
    ...
  }: {
    config = lib.mkMerge [
      {
        programs = {
          gamemode.enable = true;
          steam.enable = true;
        };

        environment.systemPackages = with pkgs; [
          heroic
          lutris
          protonup-qt
        ];
      }
      (lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [self.homeModules.gaming];
      })
    ];
  };
}
