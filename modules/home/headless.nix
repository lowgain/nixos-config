{self, ...}: {
  flake.homeModules.headless = {
    imports = [
      self.homeModules.shell
    ];
  };
}
