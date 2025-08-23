{
  perSystem = { pkgs, ... }: {
    devShells = {
      default = pkgs.mkShell {
        name = "nixos-flake-shell";
        meta.description = "Shell environment for modifying the Nix configuration";
        packages = with pkgs; [
          just
          nixd
          nixfmt-rfc-style
        ];
      };
    };
  };
}
