{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
in
{
  # imports = [ inputs.stylix.homeModules.stylix ];
  stylix = {
    enable = true;
    targets.zen-browser.profileNames = [ "default" ];
    targets.qt.enable = false;
  };
}
