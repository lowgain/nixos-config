{ flake, pkgs, ... }:

{
  imports = [
    flake.inputs.nixos-wsl.nixosModules.default
  ];

  programs.nix-ld.enable = true;

  wsl = import ./wsl.nix // {
    enable = true;
  };
}
