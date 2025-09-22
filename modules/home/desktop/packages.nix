{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
in
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  home.packages = with pkgs; [
    nautilus
    blueberry
    firefox
    ani-cli
  ];

  # Spotify terminal application
  programs.spotify-player.enable = true;

  # Terminal file manager
  programs.lf.enable = true;

  # Nixcord declarative discord on nix
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;
  };

  services = {
    network-manager-applet.enable = true;
    udiskie.enable = true;
    cliphist.enable = true;
  };

  # Enable cava the terminal based audio visualizer
  programs.cava.enable = true;
}
