{pkgs, ...}: {
  imports = [
    ./disk-config.nix
    ./preservation.nix
  ];

  hardware = {
    facter = {
      enable = true;
      reportPath = ./facter.json;
    };
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    sane.enable = true;
  };

  powerManagement.powertop.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "quiet"
      "re.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
    consoleLogLevel = 3;
    loader = {
      limine = {
      	enable = true;
        secureBoot.enable = true;
      };
      timeout = 0;
    };
    plymouth = {
      enable = true;
      # theme = "text";
    };
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      wheelNeedsPassword = false;
    };
    rtkit.enable = true;
    tpm2.enable = true;
  };

  time.timeZone = "America/Nassau";

  networking = {
    hostName = "frying-pan";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    nftables.enable = true;
    resolvconf.enable = false;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      nano
      vim
      wget
      (chromium.override { enableWideVine = true; })
      sbctl
      qemu
      quickemu
      tpm2-tss
      playerctl
    ];
  };

  fonts.enableDefaultPackages = true;

  services = {
    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet";
        };
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    xserver.desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        enableWaylandSession = true;
      };
    };

    thermald.enable = true;

    flatpak.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

    fwupd.enable = true;

    openssh.enable = true;

    printing.enable = true;

    ipp-usb.enable = true;

    resolved.enable = true;

    kolibri = {
      enable = true;
      port = 8081;
      openFirewall = true;
    };
  };

  programs = {
    xwayland.enable = true;

    nh.enable = true;

    direnv = {
      enable = true;
      silent = true;
    };

    tmux = {
      enable = true;
      keyMode = "vi";
    };

    git.enable = true;
  };

  users.users.lowgain = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$VlWFpODzNG9A8b3p4aqwI.$E5qQoNDwrNP/Rmhh826ZiZQtgKy9rb.Zt0SM4rRwVC3";
    extraGroups = [ "wheel" ];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
