{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    imports = [
      inputs.niri.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.noctalia-greeter
    ];

    nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri.enable = true;
  };
}
