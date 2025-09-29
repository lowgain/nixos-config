{flake, ...}: let
  inherit (flake) config;
in {
  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$launcher" = "wofi --show drun";
      "$fileManager" = "nautilus";
      "$browser" = "zen";
      input = {
        touchpad = {
          natural_scroll = true;
        };
      };
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = [
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, W, killactive,"
        "$mod, F, fullscreen,"
        "$mod, O, togglesplit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, , resizeactive,"
        "$mod, Space, exec, $launcher"
        "$mod, Return, exec, uwsm app -- $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, Q, exec, $browser"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
      ];
      exec-once = [
        "uwsm finalize"
        "hyprlock"
      ];
      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,16"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
      };
      decoration = {
        rounding = 10;
        rounding_power = 2.5;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          # vibrancy = 0.1696;
        };
      };
      windowrulev2 = ["suppressevent maximize, class:.*"];
      workspace = [
        "1, persistent:true, defaultName:home, default:true"
        "2, persistent:true, defaultName:term"
        "3, persistent:true, defaultName:web"
        "4, persistent:true, defaultName:media"
      ];
    };
  };

  services = {
    hyprpaper.enable = true;
    hypridle.enable = true;
    hyprpolkitagent.enable = true;
    dunst.enable = true;
  };

  programs = {
    kitty.enable = true; # required for the default Hyprland config
    wofi.enable = true;
    hyprshot.enable = true;
  };

  # xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
