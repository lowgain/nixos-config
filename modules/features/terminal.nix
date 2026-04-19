{self, ...}: {
  flake.nixosModules.terminal = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=14";
          pad = "10x10";
        };
        colors-dark = {
          alpha = 0.9;
          background = self.themeNoHash.dark;
          foreground = self.themeNoHash.light;
          regular0 = self.themeNoHash.dark;
          regular1 = self.themeNoHash.red;
          regular2 = self.themeNoHash.green;
          regular3 = self.themeNoHash.yellow;
          regular4 = self.themeNoHash.blue;
          regular5 = self.themeNoHash.purple;
          regular6 = self.themeNoHash.aqua;
          regular7 = self.themeNoHash.orange;
          bright0 = self.themeNoHash.gray;
          bright1 = self.themeNoHash.brightRed;
          bright2 = self.themeNoHash.brightGreen;
          bright3 = self.themeNoHash.brightYellow;
          bright4 = self.themeNoHash.brightBlue;
          bright5 = self.themeNoHash.brightPurple;
          bright6 = self.themeNoHash.brightAqua;
          bright7 = self.themeNoHash.brightOrange;
        };
        colors-light = {
          alpha = 0.9;
          background = self.themeNoHash.light;
          foreground = self.themeNoHash.dark;
          regular0 = self.themeNoHash.light;
          regular1 = self.themeNoHash.red;
          regular2 = self.themeNoHash.green;
          regular3 = self.themeNoHash.yellow;
          regular4 = self.themeNoHash.blue;
          regular5 = self.themeNoHash.purple;
          regular6 = self.themeNoHash.aqua;
          regular7 = self.themeNoHash.orange;
          bright0 = self.themeNoHash.gray;
          bright1 = self.themeNoHash.darkRed;
          bright2 = self.themeNoHash.darkGreen;
          bright3 = self.themeNoHash.darkYellow;
          bright4 = self.themeNoHash.darkBlue;
          bright5 = self.themeNoHash.darkPurple;
          bright6 = self.themeNoHash.darkAqua;
          bright7 = self.themeNoHash.darkOrange;
        };
      };
    };
  };
}
