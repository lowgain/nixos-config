{
  self,
  inputs,
  ...
}: {
  flake.homeModules.git = {pkgs, ...}: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      maintenance.enable = true;
    };
  };
}
