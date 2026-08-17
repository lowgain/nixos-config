{
  flake.homeModules.foot = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          pad = "15x15";
        };
      };
    };
  };
}
