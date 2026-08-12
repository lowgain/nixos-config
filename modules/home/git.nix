{
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      maintenance.enable = true;
    };
  };
}
