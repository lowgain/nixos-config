{...}: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        alejandra
        nixd
      ];
    };
  };
}
