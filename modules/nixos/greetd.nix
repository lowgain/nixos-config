{
  flake.nixosModules.greetd = {pkgs, ...}: {
    services.greetd.enable = true;
    programs.qtgreet = {
      enable = true;
      settings = {
        backend = "greetD";
      };
    };
  };
}
