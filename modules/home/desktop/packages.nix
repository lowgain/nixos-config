{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    blueberry
  ];

  programs.lf.enable = true;

  services = {
    network-manager-applet.enable = true;
    udiskie.enable = true;
    cliphist.enable = true;
  };
}
