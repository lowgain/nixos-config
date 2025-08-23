{
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/<uuid>";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/<uuid>";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];
}
