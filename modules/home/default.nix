{ flake, ... }:

let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  home.stateVersion = "25.05";
  imports = [ self.homeModules.common ];
}
