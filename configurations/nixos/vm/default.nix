# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.home
    self.nixosModules.desktop
    inputs.disko.nixosModules.disko
    ./configuration.nix
    ./hardware-configuration.nix
    ./disk-config.nix
  ];
}
