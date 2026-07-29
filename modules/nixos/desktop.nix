{self, ...}: {
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.headless
      self.nixosModules.stylix
      self.nixosModules.niri
      self.nixosModules.greetd
    ];
    programs.foot.enable = true;
    programs.firefox.enable = true;
  };
}
