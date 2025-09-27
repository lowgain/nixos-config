{ flake, ... }:

let
    inherit (flake) inputs;
in
    {
    imports = [
        inputs.nix-minecraft.nixosModules.minecraft-servers
        ./explore.nix
    ];
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

    services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
    };
}
