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
    self.nixosModules.gui
    ./configuration.nix
  ];

  # Choose your kernel (default is latest LTS)
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  services.openssh.enable = true;
  programs.ssh = {
    startAgent = true;
    extraConfig = "addKeysToAgent = yes";
  };

  # Enable home-manager for "lowgain" user
  home-manager.users."lowgain" = {
    imports = [ (self + /configurations/home/lowgain.nix) ];
  };
  home-manager.backupFileExtension = "backup";
}
