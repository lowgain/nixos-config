# List of users for darwin or nixos system and their top-level configuration.
{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake.inputs) self;
  mapListToAttrs = m: f:
    lib.listToAttrs (
      map (name: {
        inherit name;
        value = f name;
      })
      m
    );
in {
  options = {
    myusers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of usernames";
      defaultText = "All users under ./configuration/home are included by default";
      default = let
        dirContents = builtins.readDir (self + /configurations/home);
        fileNames = builtins.attrNames dirContents; # Extracts keys: [ "lowgain.nix" ]
        regularFiles = builtins.filter (name: dirContents.${name} == "regular") fileNames; # Filters for regular files
        baseNames = map (name: builtins.replaceStrings [".nix"] [""] name) regularFiles; # Removes .nix extension
      in
        baseNames;
    };
  };

  config = {
    # For home-manager to work.
    # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
    users.users = mapListToAttrs config.myusers (
      name:
        lib.optionalAttrs pkgs.stdenv.isDarwin {
          home = "/Users/${name}";
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux {
          initialPassword = "${name}";
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
          openssh.authorizedKeys.keys = [
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHSgdOXVtejXsfrEOq7/oMxUYabcphI+FdgCKcbHw9WKAAAAC3NzaDpsb3dnYWlu"
          ];
        }
    );

    # Enable home-manager for our user
    home-manager.users = mapListToAttrs config.myusers (name: {
      imports = [(self + /configurations/home/${name}.nix)];
    });

    # Set home-manager backup file extension
    home-manager.backupFileExtension = "home-backup";

    # All users can add Nix caches.
    nix.settings.trusted-users =
      [
        "root"
      ]
      ++ config.myusers;
  };
}
