{
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "nixos-wsl";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."lowgain".isNormalUser = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "24.11";
}
