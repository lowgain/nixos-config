{
  flake.nixosModules.htpcHardware = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/8805f5d7-754e-4ea9-919d-507a667953ff";
      fsType = "ext4";
      options = ["noatime"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3433-6706";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/a259dcde-9b0e-49a5-9ac1-df3af92c45af";}
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
