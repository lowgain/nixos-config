{inputs, ...}: {
  flake.homeModules.noctalia = {
    imports = ["${inputs.home-manager-unstable}/modules/programs/noctalia.nix"];
    programs.noctalia = {
      enable = true;
      settings = {
        shell = {
          font = "Atkinson Hyperlegible Next";
          settings_show_advanced = true;
          niri_overview_type_to_launch_enabled = true;
          greeter_sync.auto_sync = true;
          panel = {
            session_placement = "floating";
            session_position = "center";
          };
        };
        theme = {
          mode = "dark";
          source = "community";
          community = "everforest";
          templates = {
            builtin_ids = [
              "btop"
              "foot"
              "gtk3"
              "gtk4"
              "niri"
              "starship"
            ];
            community_ids = [
              "qutebrowser"
              "neovim"
              "heroiclauncher"
              "prismlauncher"
              "steam"
              "fastfetch"
              "papirus-icons"
              "bat"
              "fzf"
              "lazygit"
              "tmux"
              "yazi"
            ];
          };
        };
        wallpaper = {
          enabled = true;
          transition = ["fade"];
        };
        bar.default = {
          end = [
            "tray"
            "network"
            "bluetooth"
            "volume"
            "battery"
            "control-center"
          ];
          margin_ends = 0;
          radius_top_left = 0;
          radius_top_right = 0;
          start = [
            "workspaces"
            "media"
          ];
        };
        location = {
          custom_schedule = true;
          sunrise = "07:30";
          sunset = "20:30";
        };
      };
    };
    wayland.windowManager.niri.settings = {
      spawn-at-startup = ["noctalia"];
      _children = [
        {
          window-rule._children = [
            {geometry-corner-radius = 20;}
            {clip-to-geometry = true;}
          ];
        }
        {
          window-rule._children = [
            {match._props = {app-id = "dev.noctalia.Noctalia";};}
            {open-floating = true;}
            {default-column-width = { fixed = 800; }; }
            {default-window-height = { fixed = 600; }; }
          ];
        }
        {
          layer-rule._children = [
            {match._props = {namespace="^noctalia-backdrop";};}
            {place-within-backdrop = true;}
          ];
        }
      ];
      switch-events = {
        lid-close.spawn = ["noctalia" "msg" "session" "lock-and-suspend"];
      };
      binds = {
        "Mod+Space".spawn = ["noctalia" "msg" "panel-toggle" "launcher"];
        "Mod+S".spawn = ["noctalia" "msg" "panel-toggle" "control-center"];
        "Mod+Comma".spawn = ["noctalia" "msg" "settings-toggle"];
        "Alt+Tab".spawn = ["noctalia" "msg" "window-switcher"];
        "Mod+Period".spawn = ["noctalia" "msg" "panel-toggle" "session"];

        "XF86AudioRaiseVolume".spawn = ["noctalia" "msg" "volume-up"];
        "XF86AudioLowerVolume".spawn = ["noctalia" "msg" "volume-down"];
        "XF86AudioMute".spawn = ["noctalia" "msg" "volume-mute"];
        "XF86MonBrightnessUp".spawn = ["noctalia" "msg" "brightness-up"];
        "XF86MonBrightnessDown".spawn = ["noctalia" "msg" "brightness-down"];
      };
      debug.honor-xdg-activation-with-invalid-serial = {};
    };
  };
}
