{
  networking.hostName = "nixos-wsl";

  # Disable fwupd firmware downloads
  services.fwupd.enable = false;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "24.11";
}
