{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = [inputs.noctalia.homeModules.default];

    programs.noctalia = {
      enable = true;
      settings = {
        backdrop.enabled = true;
        shell = {
          app_icon_colorize = true;
          font_family = "Atkinson Hyperlegible Next";
          setup_wizard_enabled = false;
          niri_overview_type_to_launch_enabled = true;
          polkit_agent = true;
          time_format = "%l:%M %P";
          greeter_sync = {
            auto_sync = true;
          };
        };
        theme = {
          mode = "dark";
          source = "community";
          community_palette = "Everforest Alt";
          templates = {
            builtin_ids = ["btop" "foot" "gtk3" "gtk4" "niri" "qt" "starship"];
            community_ids = [
              "qutebrowser"
              "neovim"
              "heroiclauncher"
              "prismlauncher"
              "steam"
              "fastfetch"
              "bat"
              "fzf"
              "lazygit"
              "tmux"
            ];
          };
        };
        wallpaper = {
          enabled = true;
          fill_mode = "crop";
          fill_color = "#48584E";
          transition = ["fade"];
          default = "../../media/walls/picture-shrine-green.jpg";
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
        nightlight = {
          enabled = false;
          # temperature_night = 4500;
        };
        weather.unit = "imperial";
        location = {
          latitude = 26.5377;
          longitude = 77.0667;
          # custom_scedule = true;
          # sunrise = "08:00";
          # sunset = "20:00";
        };
        widget.clock.format = "%l:%M %P";
      };
    };
  };
}
