{
  inputs,
  ...
}: {
  flake.homeModules.niri = {
    lib,
    ...
  }: {
    imports = [
      "${inputs.home-manager-unstable}/modules/services/window-managers/niri.nix"
    ];

    programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "15x15";
          font = "monospace:size=14";
        };
        colors-dark.alpha = 0.8;
        colors-light.alpha = 0.8;
      };
    };

    services = {
      polkit-gnome.enable = true;
      gnome-keyring.enable = lib.mkDefault true;
    };

    wayland.windowManager.niri = {
      enable = true;
      enableDefaultConfig = true;
      settings = {
        input.focus-follows-mouse = {};
        prefer-no-csd = {};
        binds = {
          "Mod+Return".spawn = ["foot"];
          "Mod+T".spawn = ["foot"];
        };
      };
    };
  };
}
