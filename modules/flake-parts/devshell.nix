{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "nixos-config-shell";
      meta.description = "Dev environment for nixos-config";
      packages = with pkgs; [
        just
        nixfmt
        nixd
        nix-output-monitor
      ];
    };
  };
}
