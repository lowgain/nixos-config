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
    };

    programs.nh = {
      enable = true;
      flake = "/home/user/Dev/lowgain/nixos-config";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };
  };
}
