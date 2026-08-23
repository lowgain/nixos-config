{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [inputs.noctalia.homeModules.default];

    programs.noctalia = {
      enable = true;
      settings = {
        shell = {
          setup_wizard_enabled = false;
          niri_overview_type_to_launch_enabled = true;
          polkit_agent = true;
          greeter_sync = {
            auto_sync = true;
          };
        };
        wallpaper = {
          enabled = true;
          fill_mode = "crop";
          fill_color = "#282828";
          transition = ["fade"];
          default = "../../media/walls/treasure-planet-spaceship.png";
        };
        bar.default = {
          radius = 0;
          radius_bottom_left = 12;
          radius_bottom_right = 12;
          margin_ends = 0;
          start = ["workspaces" "media"];
          center = ["clock"];
          end = ["tray" "battery" "volume" "network" "control-center"];
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
