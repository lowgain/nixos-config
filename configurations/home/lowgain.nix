{flake, ...}: let
  inherit (flake) config inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.default
  ];

  home.username = "lowgain";
}
