{
  config = {
    perSystem = {pkgs, ...}: {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
          nixd
        ];
      };
    };
  };
}
