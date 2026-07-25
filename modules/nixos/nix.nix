{self, ...}: {
  flake.nixosModules.nix = {pkgs, ...}: {
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
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
        randomizedDelaySec = "10min";
      };
    };
  };
}
