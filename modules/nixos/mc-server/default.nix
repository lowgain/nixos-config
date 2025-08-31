{ flake, pkgs, ... }:

let 
  inherit (flake) inputs;
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
in
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  # Overlays
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers = {
      vanilla = (import ./vanilla-server.nix pkgs);
    };
  };
}
