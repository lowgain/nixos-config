{
  flake.nixosModules.desktop = {pkgs, ...}: {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      sane.enable = true;
    };

    security = {
      sudo.wheelNeedsPassword = false;
      rtkit.enable = true;
      polkit.enablePkexecWrapper = true;
    };

    powerManagement.resumeCommands = ''
      rmmod iwlwifi
      modprobe iwlwifi
    '';

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      printing.enable = true;
      ipp-usb.enable = true;

      libinput.enable = true;

      udisks2.enable = true;
    };

    programs = {
      mtr.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
