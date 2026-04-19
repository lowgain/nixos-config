{self, ...}: {
  flake.nixosModules.development = {
    programs.git = {
      enable = true;
      config = {
        user = {
          name = self.name;
          email = self.email;
        };
      };
    };

    programs.direnv = {
      enable = true;
      silent = true;
    };
  };
}
