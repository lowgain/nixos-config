{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, ...}@inputs: {
    formatter = builtins.mapAttrs (_: pkgs: pkgs.alejandra) nixpkgs.legacyPackages;

    devShells = builtins.mapAttrs (_: pkgs: {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          alejandra
          nixd
        ];
      };
    }) nixpkgs.legacyPackages;

    packages = builtins.mapAttrs (_: pkgs: {
      kolibri = pkgs.callPackage ./packages/kolibri.nix { };
    }) nixpkgs.legacyPackages;

    nixosModules.kolibri = ./modules/kolibri.nix;

    nixosConfigurations = import ./hosts { inherit inputs self; };
  };
}
