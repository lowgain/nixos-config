{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
in {
  imports = [inputs.jovian.nixosModules.default];

  hardware.xone.enable = true;

  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs.gamemode.enable = true;

  jovian = {
    hardware.has.amd.gpu = true;
    steam = {
      updater.splash = "vendor";
      enable = true;
      autoStart = true;
      user = "lowgain";
      desktopSession = "plasma";
    };
    steamos = {
      useSteamOSConfig = true;
    };
  };
}
