{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.kernelParams = [ "quiet" "splash" "udev.log_level=3" ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  networking = {
    hostName = "cookie-sheet";
    wireless.enable = true; # Enables wireless support via wpa_supplicant.
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # Bluetooth enable
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Select internationalisation properties.
  time.timeZone = "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;

  services.logind.lidSwitch = "ignore";

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  # Enable touchpad support
  services.libinput.enable = true;

  # Enable Flash Drives
  services.udisks2.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable/";
  };

}
