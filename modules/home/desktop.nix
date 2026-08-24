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

    home = {
      packages = with pkgs; [
        qbittorrent
      ];
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
