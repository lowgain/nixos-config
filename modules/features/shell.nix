{self, ...}: {
  flake.nixosModules.shell = {...}: {
    imports = [
      self.nixosModules.neovim
    ];
    programs.bash = {
      enableLsColors = true;
    };
    programs.starship = {
      enable = true;
    };
  };
}
