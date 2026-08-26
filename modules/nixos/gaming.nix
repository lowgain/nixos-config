{
  flake.nixosModules.gaming = {pkgs, ...}: {
    hardware.graphics.enable32Bit = true;

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
