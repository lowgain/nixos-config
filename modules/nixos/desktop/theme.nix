{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/renders/3d_gruvbox.png";
      hash = "sha256-kxlOVzVgkUxYnAAZEwg77OzXd0SUMOX+2WqRGq7LQgI=";
    };

    fonts = {
      serif.package = pkgs.noto-fonts;
      serif.name = "Noto Serif";
      sansSerif.package = pkgs.noto-fonts;
      sansSerif.name = "Noto Sans-Serif";
      monospace.package = pkgs.nerd-fonts.jetbrains-mono;
      monospace.name = "Jetbrains Mono";
      emoji.package = pkgs.noto-fonts-emoji;
      emoji.name = "Noto Color Emoji";
      # sizes.applications = 12;
      # sizes.desktop = 10;
      # sizes.popups = config.stylix.fonts.sizes.desktop;
      # sizes.terminal = config.stylix.fonts.sizes.applications;
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

    targets.gnome.enable = false;
    targets.qt.enable = false;
  };
}
