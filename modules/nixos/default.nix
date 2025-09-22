# Configuration common to all Linux systems
{ flake, lib, ... }:

let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [ self.nixosModules.common ];

  services.openssh = {
    enable = lib.mkDefault true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
  };
}
