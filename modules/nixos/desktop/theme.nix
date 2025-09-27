{
  stylix = {
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/renders/3d_gruvbox.png";
      hash = "sha256-kxlOVzVgkUxYnAAZEwg77OzXd0SUMOX+2WqRGq7LQgI=";
    };

    icons = {
      enable = true;
      dark = "Papirus Dark";
      light = "Papirus Light";
      package = pkgs.papirus-icon-theme;
    };

    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 0.7;
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
    };
  };
}
