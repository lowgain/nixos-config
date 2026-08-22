{
  flake.nixosModules.nix = {
    nixpkgs.config.allowUnfree = true;

    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["@wheel"];
      };
      optimise = {
        automatic = true;
        dates = "weekly";
      };
    };

    programs.nh = {
      enable = true;
      flake = "/home/lowgain/Dev/nixos-config";
      clean = {
        enable = true;
        extraArgs = " --keep 3 --no-direnv";
      };
    };
  };
}
