# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.common
    inputs.disko.nixosModules.disko
    ./configuration.nix
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      #   PermitRootLogin = "no";
    };
  };
}
