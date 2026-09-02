{
  flake.homeModules.foot = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "15x15";
          font = "Atkinson Hyperlegible Mono:size=14";
        };
        colors-dark.alpha = 0.8;
        colors-light.alpha = 0.8;
      };
    };
  };
}
