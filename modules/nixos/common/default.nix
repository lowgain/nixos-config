{lib, ...}: {
  imports = with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  # Enable TPM2 module support
  security.tpm2.enable = lib.mkDefault true;

  # Enable fwupd firmware downloads
  services.fwupd.enable = lib.mkDefault true;

  # Enable thermald thermal monitor daemon
  services.thermald.enable = true;

  # Create man page cache on build
  documentation.man.generateCaches = true;
}
