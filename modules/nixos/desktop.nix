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

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        noto-fonts
        caladea
        carlito
        dejavu_fonts
        gentium
        liberation_ttf
        libertine
        atkinson-hyperlegible-next
        nerd-fonts.atkynson-mono
        noto-fonts-color-emoji
      ];
      fontconfig = {
        enable = true;
        serif = ["Atkinson Hyperlegible Next Regular"];
        sansSerif = ["Atkinson Hyperlegible Next Regular"];
        monospace = ["Atkinson Hyperlegible Mono Regular"];
        emoji = ["Noto Color Emoji"];
      };
    };

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
