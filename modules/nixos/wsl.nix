{
  flake,
  pkgs,
  config,
  ...
}:
{
  imports = [
    flake.inputs.nixos-wsl.nixosModules.default
  ];

  programs.nix-ld.enable = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  wsl = {
    enable = true;
    defaultUser = "${flake.config.me.username}";
    docker-desktop.enable = true;
    usbip.enable = true;
    startMenuLaunchers = true;
  };
}
