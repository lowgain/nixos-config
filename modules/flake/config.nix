# Top-level configuration for everything in this repo.
#
# Values are set in 'me.nix' in repo root.
{ lib, system, ... }:
let
  userSubmodule = lib.types.submodule {
    options = {
      username = lib.mkOption {
        type = lib.types.str;
      };
      fullname = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
in
{
  imports = [
    ../../me.nix
  ];
  options = {
    me = lib.mkOption {
      type = userSubmodule;
    };
  };
}
