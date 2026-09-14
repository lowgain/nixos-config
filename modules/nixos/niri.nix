{self, ...}: {
  flake.nixosModules.niri = {
    lib,
    pkgs,
    options,
    ...
  }: {
    config = lib.mkMerge [
      {
        hardware.graphics.enable = lib.mkDefault true;

        environment = {
          sessionVariables.NIXOS_OZONE_WL = "1";
          systemPackages = [pkgs.nautilus];
        };

        security.polkit.enable = true;

        services.logind.settings.Login = {
          HandleLidSwitch = "ignore";
          HandleLidSwitchExternalPower = "ignore";
          HandleLidSwitchDocked = "ignore";
        };

        programs = {
          dconf.enable = true;
          niri.enable = true;
        };
      }
      (lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [self.homeModules.niri];
      })
    ];
  };
}
