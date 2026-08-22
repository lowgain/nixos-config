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

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      printing.enable = true;

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

    environment.systemPackages = with pkgs; [
      nautilus
      simple-scan
      onlyoffice-desktopeditors
    ];
  };
}
