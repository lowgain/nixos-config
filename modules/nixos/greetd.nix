{
  flake.nixosModules.greetd = {pkgs, ...}: {
    environment.etc."greetd/environments".text = ''
      niri
      bash
    '';

    services.greetd = {
      enable = true;
      settings = rec {
        default_session = {
          command = "${pkgs.cage}/bin/cage -s -- ${pkgs.gtkgreet}/bin/gtkgreet";
          user = "lowgain";
        };
      };
    };
  };
}
