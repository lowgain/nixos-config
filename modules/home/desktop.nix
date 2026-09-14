{
  flake.homeModules.desktop = {pkgs, ...}: {
    services = {
      udiskie.enable = true;
    };

    programs = {
      cmus.enable = true;
      pyradio.enable = true;
      onlyoffice.enable = true;
    };

    fonts = {
      fontconfig.enable = true;
      fontconfig.defaultFonts = {
        serif = ["Atkinson Hyperlegible Next"];
        sansSerif = ["Atkinson Hyperlegible Next"];
        monospace = ["AtkynsonMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };

    home = {
      file.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Amber";
      pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Amber";
        size = 24;
      };
      packages = with pkgs; [
        # System Apps
        simple-scan
        pdfsam-basic
      ];
    };

    xdg = {
      userDirs.enable = true;
      mimeApps.enable = true;
    };
  };
}
