{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    # hyprcursor.enable = true;
    # hyprcursor.size = 16;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
      size = 12;
    };
  };
}
