{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bibata-cursors
      jamesdsp
    ];
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = let
        noctaliaExe = lib.getExe self'.packages.myNoctalia;
      in {
        spawn-at-startup = [
          noctaliaExe
        ];

        prefer-no-csd = _: {};

        cursor = {
          xcursor-theme = "Bibata-Modern-Amber";
          xcursor-size = 24;
        };

        input = {
          focus-follows-mouse = _: {};

          keyboard.xkb.layout = "us";

          touchpad = {
            natural-scroll = _: {};
            tap = _: {};
          };

          mouse = {
            accel-profile = "flat";
          };
        };

        binds = {
          "Mod+Return".spawn-sh = "foot";

          "Mod+W".close-window = _: {};
          "Mod+M".maximize-column = _: {};
          "Mod+F".fullscreen-window = _: {};
          "Mod+Shift+F".toggle-window-floating = _: {};
          "Mod+C".center-column = _: {};

          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+K".focus-window-up = _: {};
          "Mod+J".focus-window-down = _: {};

          "Mod+Left".focus-column-left = _: {};
          "Mod+Right".focus-column-right = _: {};
          "Mod+Up".focus-window-up = _: {};
          "Mod+Down".focus-window-down = _: {};

          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+L".move-column-right = _: {};
          "Mod+Shift+K".move-window-up = _: {};
          "Mod+Shift+J".move-window-down = _: {};

          "Mod+1".focus-workspace = "1";
          "Mod+2".focus-workspace = "2";
          "Mod+3".focus-workspace = "3";
          "Mod+4".focus-workspace = "4";

          "Mod+Shift+1".move-column-to-workspace = "1";
          "Mod+Shift+2".move-column-to-workspace = "2";
          "Mod+Shift+3".move-column-to-workspace = "3";
          "Mod+Shift+4".move-column-to-workspace = "4";

          "Mod+Space".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
          "Mod+S".spawn-sh = "${noctaliaExe} ipc call controlCenter toggle";
          "Mod+Comma".spawn-sh = "${noctaliaExe} ipc call settings toggle";
          "Mod+Period".spawn = ["${noctaliaExe}" "ipc" "call" "lockScreen" "lock"];
          "Ctrl+Alt+Escape".spawn-sh = "${noctaliaExe} ipc call systemMonitor toggle";

          "XF86AudioRaiseVolume".spawn = ["${noctaliaExe}" "ipc" "call" "volume" "increase"];
          "XF86AudioLowerVolume".spawn = ["${noctaliaExe}" "ipc" "call" "volume" "decrease"];
          "XF86AudioMute".spawn = ["${noctaliaExe}" "ipc" "call" "volume" "muteOutput"];
          "XF86AudioPlay".spawn = ["${noctaliaExe}" "ipc" "call" "media" "play"];
          "XF86AudioPause".spawn = ["${noctaliaExe}" "ipc" "call" "media" "pause"];
          "XF86AudioNext".spawn = ["${noctaliaExe}" "ipc" "call" "media" "next"];
          "XF86AudioPrev".spawn = ["${noctaliaExe}" "ipc" "call" "media" "previous"];

          "XF86MonBrightnessUp".spawn = ["${noctaliaExe}" "ipc" "call" "brightness" "increase"];
          "XF86MonBrightnessDown".spawn = ["${noctaliaExe}" "ipc" "call" "brightness" "decrease"];

          "Mod+Ctrl+H".set-column-width = "-5%";
          "Mod+Ctrl+L".set-column-width = "+5%";
          "Mod+Ctrl+J".set-window-height = "-5%";
          "Mod+Ctrl+K".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-column-left = _: {};
          "Mod+WheelScrollUp".focus-column-right = _: {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: {};
        };

        layout = {
          gaps = 10;
          background-color = "transparent";
          focus-ring = {
            width = 2;
            active-color = self.theme.brightOrange;
            inactive-color = self.theme.gray;
            urgent-color = self.theme.red;
          };
          border = {
            width = 2;
            active-color = self.theme.brightOrange;
            inactive-color = self.theme.gray;
            urgent-color = self.theme.red;
          };
        };

        workspaces = {
          "1" = _: {};
          "2" = _: {};
          "3" = _: {};
          "4" = _: {};
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        window-rules = [
          {
            open-maximized = true;
            geometry-corner-radius = 10;
            clip-to-geometry = true;
          }
        ];

        layer-rules = [
          {
            matches = [
              {
                namespace = "^noctalia-wallpaper*";
              }
            ];
            place-within-backdrop = true;
          }
        ];

        debug = {
          # Allows notification actions and window activation from Noctalia.
          honor-xdg-activation-with-invalid-serial = _: {};
        };
      };
    };
  };
}
