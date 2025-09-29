# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  nixos-unified.sshTarget = "root@static.198.236.12.49.clients.your-server.de";

  imports = [
    self.nixosModules.default
    self.nixosModules.mc-servers
    inputs.disko.nixosModules.disko
    ./configuration.nix
  ];
}
