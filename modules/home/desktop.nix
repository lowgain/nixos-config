{self, ...}: {
  flake.homeModules.desktop = {
    imports = [
      # self.homeModules.niri
      self.homeModules.headless
    ];
  };
}
