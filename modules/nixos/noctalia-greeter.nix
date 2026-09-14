{inputs, ...}: {
  flake.nixosModules.noctalia-greeter = {pkgs, ...}: {
    imports = [
      "${inputs.nixpkgs-unstable}/nixos/modules/services/display-managers/noctalia-greeter.nix"
    ];
    services.displayManager.noctalia-greeter = {
      enable = true;
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Amber";
      };
      settings = {
        cursor = {
          size = 24;
          theme = "Bibata-Modern-Amber";
        };
        keyboard.layout = "us";
        appearance.scheme = "Synced";
      };
    };
  };
}
