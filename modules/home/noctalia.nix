{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [inputs.noctalia.homeModules.default];

    programs.noctalia = {
      enable = true;
      settings = {
        wallpaper = {
          transition = ["fade"];
        };
        bar.default = {
          radius = 0;
          radius_bottom_left = 12;
          radius_bottom_right = 12;
          margin_ends = 0;
          start = ["workspaces" "media"];
          center = ["clock"];
          end = ["tray" "control-center"];
        };
        nightlight.enabled = true;
        weather.unit = "imperial";
        location = {
          latitude = 26.5148;
          longitude = 77.3013;
        };
      };
    };
  };
}
