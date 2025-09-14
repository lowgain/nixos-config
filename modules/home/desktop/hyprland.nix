{
  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    package = null;
    portalPackage = null;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
      ];
      exec-once = [
        "uwsm finalize"
        "hyprlock"
        "hyprpanel"
      ];
    };
  };

  services = {
    hyprpaper.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    hyprsunset = true;
    hyprpolkitagent.enable = true;
    hyprutils.enable = true;
    dunst.enable = true;
  };

  programs = {
    kitty.enable = true; # required for the default Hyprland config
    wofi.enable = true;
    hyprshot.enable = true;
  };
}
