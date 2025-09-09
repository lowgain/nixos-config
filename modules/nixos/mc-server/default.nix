{ flake, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.arion pkgs.rcon ];
  networking.firewall.allowedTCPPorts = [ 25565 ];
}
