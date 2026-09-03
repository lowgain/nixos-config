{
  flake.nixosModules.gaming = {pkgs, ...}: {
    programs = {
      gamemode.enable = true;
      steam.enable = true;
    };

    environment.systemPackages = with pkgs; [
      heroic
      lutris
      protonup-qt
    ];
  };
}
