{inputs, ...}: {
  flake.nixosModules.nix = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          stable = import inputs.nixpkgs-stable {
            inherit (final) system config;
          };
        })
      ];
    };

    nix = {
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
      settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "@wheel"];
      };
    };

    programs = {
      direnv.enable = true;
      nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep 3 --no-direnv --optimise";
        };
      };
    };
  };
}
