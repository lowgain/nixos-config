{
  modulesPath,
  pkgs,
  ...
} @ args: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  users.users.root.initialPassword = "admin123";
  users.users.root.openssh.authorizedKeys.keys =
    [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3V4mLNq2taQO9dBJVhcfxwZGbfzJ9BLnGV6QM5dqQDgCpnliw2SBwa03Fxv3N4w0JKhu9SevQ1FbPeTSPpozYKYnONf50Br+pt1B7z7HusUmI3mlxEs/lZrQab+/vy8pQZLkADQUtywVFXRCILj/r36QhfchQACEF6q3pNFi+8NgIDiUA9Xg4L4nei9VnbcmOFFrU+W6FH2ct210PGkHSuLKSXt1EzitF+YTQlQJgCW5Oq6SCWA71vdKu6aYIEd5wugIdxIQrVgrDbg+5HO7QmanFUKXzTHPR200ua5hsiBIlbmvE9sl/rC7vGjv6wNpqvEZNddjqT56sv+IT9YAq711Snd/6d/4zSdeDprIH3fhCQd3TVr445ALzSW7Rx/xI5T1QL/C1MhXbY8rPZ0Lw9fDhSsX5aZDc7fmqDFUiWC+E5TIskdI7BI2QmITMexc+hfnkRWlg5WvhrE35aD0UNr01RllPzvmSim8ay1ZtK6juX+W0aMeymOMNaiQLuZuqL9QX8Z1cpM5XiZMzLiMrqu/C+jDL09m0ERR/w7hPulattpiwyInLI+ywoV5E1kiepPMvdjOrFO6hkoZ9RHTSO/z7qtB4CPYYXpX59LxYPkcFrP57Q3Ll2sM0eqT8jewpzSIrp8h06g2dnLd8BmtHrBn4wmx3gsl8+PM+nCaxVw=="
    ]
    ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed

  environment.systemPackages = with pkgs; [
    tmux
  ];

  networking.hostName = "mc-server";

  nixpkgs.hostPlatform = "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "25.05";
}
