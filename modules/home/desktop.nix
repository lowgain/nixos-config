{self, ...}: {
  flake.homeModules.desktop = {pkgs, ...}: {
    imports = [
      self.homeModules.browsers
      self.homeModules.mpv
      self.homeModules.shell
    ];

    services = {
      udiskie.enable = true;
    };

    programs = {
      cmus.enable = true;
      pyradio.enable = true;
      libreoffice = {
        enable = true;
        package = pkgs.libreoffice-qt;
      };
    };

    home = {
      packages = with pkgs; [
        # System Apps
        simple-scan
        qbittorrent
        hunspell
        hunspellDicts.en_US
        hyphenDicts.en_US
        pdfsam-basic
      ];
      file."icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Amber";
      pointerCursor = {
        enable = true;
        gtk.enable = true;
        name = "Bibata-Modern-Amber";
        package = pkgs.bibata-cursors;
        size = 24;
      };
    };

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    xdg = {
      userDirs.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
          "inode/directory" = "lf.desktop";
        };
      };
    };
  };
}
