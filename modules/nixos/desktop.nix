{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    options,
    ...
  }: {
    imports = [self.nixosModules.neovim];
    config = lib.mkMerge [
      {
        hardware.sane.enable = true;

        powerManagement = {
          enable = true;
          powertop.enable = true;
        };

        security = {
          sudo.wheelNeedsPassword = false;
          rtkit.enable = true;
        };

        fonts = {
          packages = with pkgs; [
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
          enableDefaultPackages = true;
          fontDir.enable = true;
        };

        services = {
          avahi = {
            enable = true;
            nssmdns4 = true;
            nssmdns6 = true;
            openFirewall = true;
          };
          pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
          };
          printing = {
            enable = true;
            drivers = with pkgs; [
              cups-filters
              cups-browsed
              gutenprint
              # hplip # HP Drivers
              # brgenml1lpr # Brother drivers
              # brgenml1cupswrapper # Brother drivers
              # epson-escpr2 # Brother drivers
            ];
          };
          ipp-usb.enable = true;
          libinput.enable = true;
          udisks2.enable = true;
        };

        programs = {
          gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
          };
        };
      }
      (lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [
          self.homeModules.desktop
          self.homeModules.shell
          self.homeModules.browsers
          self.homeModules.mpv
        ];
      })
    ];
  };
}
