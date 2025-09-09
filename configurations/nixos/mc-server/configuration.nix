{
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "mc-server";

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "25.05";
}
