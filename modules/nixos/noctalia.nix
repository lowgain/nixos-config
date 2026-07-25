{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.noctalia = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.noctalia.nixosModules.default
      self.nixosModules.noctalia-greeter
    ];
    programs.noctalia = {
      enable = true;
      recommendedServices = true;
    };
  };
}
