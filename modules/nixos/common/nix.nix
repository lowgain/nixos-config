{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    trusted-users = [ "@wheel" ];
    experimental-features = "nix-command flakes";
  };
}
