{flake, ...}: let
  inherit (flake) config inputs;
  inherit (inputs) self;
in {
  imports = [self.homeModules.common];
  home.stateVersion = "25.05";
}
