{self, ...}: {
  flake.homeModules.desktop = {
    imports = [
      self.homeModules.mangowm
      self.homeModules.headless
    ];
  };
}
