{self, inputs, ...}: {
  flake.nixosModules.noctalia = {
    imports = [
      inputs.noctalia.nixosModules.default
      self.nixosModules.noctalia-greeter
    ];
    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
  };
}
