{
  flake.nixosModules.greetd = {pkgs, ...}: let
    mangoConfig = pkgs.writeText "greetd-mango-config" ''
      exec-once=${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; mmsg dispatch quit
    '';
  in {
    environment.etc."greetd/environments".text = ''
      mango
      bash
    '';

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.mango}/bin/mango -c ${mangoConfig}";
        };
      };
    };
  };
}
