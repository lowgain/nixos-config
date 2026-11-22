{
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/secureboot"
        "/etc/crypttab"
        "/var/lib/bluetooth"
        "/var/lib/fprint"
        "/var/lib/fwupd"
        "/var/lib/libvirt"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/rfkill"
        "/var/lib/systemd/timers"
        "/var/lib/flatpak"
        "/var/lib/sbctl"
        "/var/lib/iwd"
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
            ".local/share/flatpak"
            ".local/share/qBittorrent"
            ".config/chromium/Default"
            ".config/librewolf"
            ".config/qBittorrent"
            ".config/xfce4"
            ".var/app"
            "Desktop"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Projects"
            "Public"
            "Templates"
            "Videos"
          ];
        };
      };
    };
  };

  systemd = {
    suppressedSystemUnits = ["systemd-machine-id-commit.service"];
    tmpfiles.settings.preservation = {
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
