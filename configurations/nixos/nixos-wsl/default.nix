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
    self.nixosModules.wsl
    ./configuration.nix
  ];

  # Enable home-manager for "lowgain" user
  home-manager.users."lowgain" = {
    imports = [ (self + /configurations/home/lowgain.nix) ];
  };
  home-manager.backupFileExtension = "backup";

  services.openssh.enable = true;
  programs.ssh = {
    startAgent = true;
    extraConfig = "addKeysToAgent = yes";
  };
}
