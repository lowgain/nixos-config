{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
      self.nixosModules.noctalia
    ];
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    programs.niri.enable = true;
  };
}
