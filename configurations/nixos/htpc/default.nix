{flake, ...}: let
  inherit (flake) inputs;
in {
  imports = [
    inputs.jovian.nixosModules.default
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
