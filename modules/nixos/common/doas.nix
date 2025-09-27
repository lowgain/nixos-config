{ flake, ... }:

let
  inherit (flake) config;
in
{
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "${config.me.username}" ];
      # Optional. retains environment variables while running commands
      # E.g. retains your NIX_PATH when applying your config
      keepEnv = true;
      # Optional. don't ask for the password for some time after a successful authentication
      persist = true;

    }
  ];
}
