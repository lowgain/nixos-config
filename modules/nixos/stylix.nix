{inputs, ...}: {
  flake.nixosModules.stylix = {pkgs, ...}: {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    home-manager.sharedModules = [
      {
        stylix = {
          targets = {
            neovim = {
              transparentBackground = {
                main = true;
                numberLine = true;
                signColumn = true;
              };
            };
          };
        };
      }
    ];

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      image = ../../media/walls/treasure-planet-spaceship.png;
      fonts = {
        serif = {
          package = pkgs.atkinson-hyperlegible-next;
          name = "Atkinson Hyperlegible Next Regular";
        };

        sansSerif = {
          package = pkgs.atkinson-hyperlegible-next;
          name = "Atkinson Hyperlegible Next Regular";
        };

        monospace = {
          package = pkgs.atkinson-hyperlegible-mono;
          name = "Atkinson Hyperlegible Mono Regular";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };

        sizes.terminal = 14;
      };

      # icons = {
      #     enable = true;
      #     package = pkgs.papirus-nord;
      #     light = auroraorange;
      #     dark = auroraorangeb;
      # };

      # cursor = {
      #     package = pkgs.bibata-cursors;
      #     name = Bibata Modern Amber;
      #     size = 32;
      # };

      opacity.terminal = 0.8;
    };
  };
}
