{inputs, ...}: {
  flake.nixosModules.nix = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        stalled-download-timeout = 1000;
      };
      optimise = {
        automatic = true;
        dates = "weekly";
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
