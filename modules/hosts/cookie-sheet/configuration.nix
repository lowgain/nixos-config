{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.cookieSheet = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.cookieSheetfig];
  };

  flake.nixosModules.cookieSheetfig = {pkgs, ...}: {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
      inputs.nixos-hardware.nixosModules.common-gpu-amd
      inputs.nixos-hardware.nixosModules.common-pc
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      self.nixosModules.cookieSheetware
      self.nixosModules.nix
      self.nixosModules.desktop
      self.nixosModules.shell
    ];

    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      kernelParams = ["quiet" "loglevel=3"];
      blacklistedKernelModules = ["i2c_smbus" "i2c_piix4"]; # Makes startup errors

      loader.systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 10;
      };
      loader.efi.canTouchEfiVariables = true;
    };

    networking = {
      nameservers = ["127.0.0.1" "::1"];
      hostName = "cookie-sheet";
      networkmanager = {
        enable = true;
        dns = "none";
      };
      nat = {
        enable = true;
        internalInterfaces = ["ve-+"];
        externalInterface = "wlp1s0";
        enableIPv6 = true;
      };
    };

    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        ipv4_servers = true;
        ipv6_servers = true;
        require_dnssec = true;
        require_nolog = true;
        require_nofilter = true;
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };

    containers.qbittorrent = {
      autoStart = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      privateNetwork = true;

      config = {
        config,
        lib,
        ...
      }: {
        imports = [inputs.sops-nix.nixosModules.sops];

        sops = {
          defaultSopsFile = ../../../secrets/cookie_sheet/secrets.yaml;
          age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
          secrets.surfshark_pem = {};
        };

        networking.wg-quick.interfaces.wg0 = {
          address = ["10.14.0.2/16"];
          dns = ["127.0.0.1"];
          privateKeyFile = config.sops.secrets.surfshark_pem.path;
          postUp = "${config.systemd.package}/bin/systemctl start qbittorrent.service";
          postDown = "${config.systemd.package}/bin/systemctl stop qbittorrent.service";
          peers = [
            {
              publicKey = "SgciXll6wGQhcyxPUdp0V0z6WwN9P3fqDoeh3N3xNjc=";
              allowedIPs = ["0.0.0.0/0"];
              endpoint = "us-atl.prod.surfshark.com:51820";
            }
          ];
        };

        services.qbittorrent = {
          enable = true;
          openFirewall = true;
          serverConfig = {
            LegalNotice.Accepted = true;
            BitTorrent = {
              Session.Interface = "wg0";
              Session.InterfaceAddress = "10.14.0.2/16";
              Session.InterfaceName = "wg0";
            };
            Preferences = {
              General.Locale = "en";
              Search.SearchEnabled = true;
              WebUI.Enabled = true;
              WebUI.Password_PBKDF2 = "@ByteArray(kS/5CnSBqn9rzFum9EWlpQ==:f3VJM4ISBf1zhz4u6EQRIKn0mLb9vLSLiApCuZBaGJZ5msYwrT7bzwoF/CDfxJadH24GBKLk57G8iNnXBguT+A==)";
              WebUI.Address = "192.168.100.11";
              WebUI.Port = 8081;
            };
          };
        };

        systemd.services.qbittorrent.wantedBy = lib.mkForce [];

        system.stateVersion = "26.05";

        networking = {
          firewall = {
            enable = true;
            allowedTCPPorts = [8081];
          };
          # Use systemd-resolved inside the container
          # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
          useHostResolvConf = lib.mkForce false;
        };

        services.resolved.enable = true;
      };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    time.timeZone = "America/Nassau";

    services.libinput.enable = true;

    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";
      HandleSuspendKey = "ignore";
      HandleSuspendKeyLongPress = "suspend";
    };

    programs = {
      ssh = {
        extraConfig = ''
          AddKeysToAgent yes
          IdentityFile ~/.ssh/id_ed25519
        '';
      };
    };

    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    # Autologin dispay manager to avoid double login
    # services.displayManager.autoLogin = {
    #   enable = true;
    #   user = "${self.name}";
    # };

    services.upower.enable = true;

    powerManagement.powertop.enable = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
