{
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "mc-server";

  # For home-manager to work.
  # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
  users.users."minecraft".isNormalUser = true;

  environment.systemPackages = [ pkgs.arion];
  networking.firewall.allowedTCPPorts = [ 25565 ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "25.05";
}
