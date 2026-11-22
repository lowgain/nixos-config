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

  outputs = inputs: {
    formatter = builtins.mapAttrs (_: pkgs: pkgs.alejandra) inputs.nixpkgs.legacyPackages;
    devShells = builtins.mapAttrs (_: pkgs: {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          alejandra
          nixd
        ];
      };
    }) inputs.nixpkgs.legacyPackages;
    nixosConfigurations = import ./hosts { inherit inputs; };
  };
}
