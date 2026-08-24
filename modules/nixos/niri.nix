{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.noctalia-greeter
    ];

    nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      nautilus
    ];
  };
}
