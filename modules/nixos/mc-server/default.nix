{ flake, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.arion ];
  networking.firewall.allowedTCPPorts = [ 25565 ];
}
