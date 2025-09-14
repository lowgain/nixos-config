{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  # Enable Display Manager
  services.displayManager.gdm.enable = true;

  # Allow screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
