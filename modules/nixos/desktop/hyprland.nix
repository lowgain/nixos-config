{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
in {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Xwayland can be disabled.
    withUWSM = true;
  };

  # Enable Display Manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Allow screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  };

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = [pkgs.kitty];
}
