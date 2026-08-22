{inputs, ...}: {
  flake.nixosModules.noctalia-greeter = {pkgs, ...}: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];
    programs.noctalia-greeter = {
      enable = true;
      settings = {
        appearance = {
          theme = "Synced";
        };
        cursor = {
          theme = "Bibata-Modern-Amber";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
      };
    };
  };
}
