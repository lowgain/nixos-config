{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = [
      self.nixosModules.niri
      self.nixosModules.audio
      self.nixosModules.browsers
      self.nixosModules.terminal
      self.nixosModules.development
    ];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    services.displayManager.gdm.enable = true;

    environment.systemPackages = with pkgs; [
      mpv
      unzip
      zip
      p7zip
      wget
      killall
      fzf
      htop
      btop
      fastfetch
      tree
      ffmpeg-full
      libqalculate
      lf
      naps2
    ];

    # Extra font packages
    fonts.packages = with pkgs; [
      cm_unicode
      corefonts
      unifont
      nerd-fonts.ubuntu-sans
      nerd-fonts.fira-code
    ];

    fonts.fontconfig.defaultFonts = {
      serif = ["Ubuntu Sans"];
      sansSerif = ["Ubuntu Sans"];
      monospace = ["FiraCode Nerd Font"];
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${self.name} = {
      description = "${self.name}'s account";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "scanner" "lp"];
      initialPassword = "${self.name}";
    };

    # Enable desktop portal and D-Bus
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    };
    security.polkit.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-volman
        ];
      };
    };

    services = {
      udisks2.enable = true;

      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };

    # Scanners
    # Note: User requires "scanner" and "lp" groups
    hardware.sane = {
        enable = true;
        extraBackends = with pkgs; [
            sane-airscan
            hplipWithPlugin
        ];
        openFirewall = true;
    };
  };
}
