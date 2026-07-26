{
  self,
  inputs,
  ...
}: {
  flake.homeModules.niri = {
    imports = [
      inputs.niri.homeModules.niri
      self.homeModules.noctalia
    ];

    programs.niri = {
      enable = true;
      settings = {
        spawn-at-startup = [
          {argv = ["noctalia"];}
        ];
        window-rules = [
          {
            clip-to-geometry = true;
            geometry-corner-radius = 20;
          }
          {
            matches = [{app-id = "dev.noctalia.Noctalia";}];
            open-floating = true;
            default-column-width.fixed = 1080;
            default-window-height.fixed = 920;
          }
        ];
        debug = {
          honor-xdg-activation-with-invalid-serial = [];
        };
        binds = {
          "Mod+Space".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher"];
          "Mod+S".action.spawn = ["noctalia" "msg" "panel-toggle" "control-center"];
          "Mod+Comma".action.spawn = ["noctalia" "msg" "settings-toggle"];
          "Mod+Return".action.spawn = ["foot"];
          "Alt+Tab".action.spawn = ["noctalia" "msg" "window-switcher"];
          "XF86AudioRaiseVolume".action.spawn = ["noctalia" "msg" "volume-up"];
          "XF86AudioLowerVolume".action.spawn = ["noctalia" "msg" "volume-down"];
          "XF86AudioMute".action.spawn = ["noctalia" "msg" "volume-mute"];
          "XF86AudioBrigthnessUp".action.spawn = ["noctalia" "msg" "brightness-up"];
          "XF86AudioBrigthnessDown".action.spawn = ["noctalia" "msg" "brightness-down"];
        };
        switch-events = {
          lid-close.action.spawn = ["noctalia" "msg" "session" "lock-and-suspend"];
        };
      };
    };
  };
}
