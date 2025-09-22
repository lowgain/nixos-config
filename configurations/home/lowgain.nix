{ flake, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
    self.homeModules.desktop
  ];

  home.username = "lowgain";
}
