{inputs, ...}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.disko.flakeModules.default
  ];
  config = {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
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
