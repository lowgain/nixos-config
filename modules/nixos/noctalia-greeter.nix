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
          cursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Amber";
            size = 24;
          };
        };
      };
    };
  };
}
