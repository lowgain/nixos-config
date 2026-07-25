{self, ...}: {
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.headless
      self.nixosModules.stylix
      self.nixosModules.niri
    ];
    programs.foot.enable = true;
    programs.firefox.enable = true;
  };
}
