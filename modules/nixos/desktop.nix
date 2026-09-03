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
        defaultFonts = {
          serif = ["Atkinson Hyperlegible Next" "Noto Serif"];
          sansSerif = ["Atkinson Hyperlegible Next" "Noto Sans"];
          monospace = ["AtkynsonMono Nerd Font"];
          emoji = ["Noto Color Emoji"];
        };
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
