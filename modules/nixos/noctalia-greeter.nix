{inputs, ...}: {
  flake.nixosModules.noctalia-greeter = {pkgs, ...}: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];
    programs.noctalia-greeter = {
      enable = true;
      settings = {
        cursor = {
          path = "${pkgs.bibata-cursors}/share/icons";
          theme = "Bibata-Modern-Amber";
          size = 24;
        };
        appearance.theme = "Synced";
      };
    };
  };
}
