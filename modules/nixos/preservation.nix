{inputs, ...}: {
  flake.nixosModules.preservation = {
    imports = [inputs.preservation.nixosModules.default];
    preservation = {
      enable = true;

      preserveAt."/persistent" = {
        directories = [
          "/etc/secureboot"
          "/var/lib/bluetooth"
          "/var/lib/fprint"
          "/var/lib/fwupd"
          "/var/lib/libvirt"
          "/var/lib/power-profiles-daemon"
          "/var/lib/systemd/coredump"
          "/var/lib/systemd/rfkill"
          "/var/lib/systemd/timers"
          "/var/log"
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ];

        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
          {
            file = "/etc/ssh/ssh_host_rsa_key";
            how = "symlink";
            configureParent = true;
          }
          {
            file = "/etc/ssh/ssh_host_ed25519_key";
            how = "symlink";
            configureParent = true;
          }
        ];

        users = {
          lowgain = {
            directories = [
              {
                directory = ".ssh";
                mode = "0700";
              }
              ".local/state/nvim"
              ".local/state/wireplumber"
              ".local/state/nix"
              ".local/share/direnv"
              "Downloads"
              "Documents"
              "Dev"
              "Games"
              "Music"
              "Pictures"
              "Videos"
            ];
          };
        };
      };
    };

    systemd.tmpfiles.settings.preservation = {
      "/home/lowgain/.config".d = {
        user = "lowgain";
        group = "users";
        mode = "0755";
      };
      "/home/lowgain/.local".d = {
        user = "lowgain";
        group = "users";
        mode = "0755";
      };
      "/home/lowgain/.local/share".d = {
        user = "lowgain";
        group = "users";
        mode = "0755";
      };
      "/home/lowgain/.local/state".d = {
        user = "lowgain";
        group = "users";
        mode = "0755";
      };
    };
  };
}
