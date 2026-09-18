{
  flake.diskoConfigurations.fridge = {
    fileSystems = {
      "/nix".neededForBoot = true;
      "/persistent".neededForBoot = true;
    };
    disko.devices = {
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "size=25%"
            "mode=755"
          ];
        };
      };
      disk = {
        main = {
          device = "/dev/nvme0n1";
          type = "disk";
          imageSize = "10G";
          content = {
            type = "gpt";
            partitions = {
              esp = {
                type = "EF00";
                size = "512M";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  passwordFile = "/tmp/secret.key";
                  settings.allowDiscards = true;
                  content = {
                    type = "btrfs";
                    extraArgs = ["-L" "nixos" "-f"];
                    subvolumes = {
                      "/persistent" = {
                        mountOptions = ["subvol=persistent" "noatime" "compress=zstd"];
                        mountpoint = "/persistent";
                      };
                      "/nix" = {
                        mountOptions = ["subvol=nix" "noatime" "compress=zstd"];
                        mountpoint = "/nix";
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap.swapfile.size = "2G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
