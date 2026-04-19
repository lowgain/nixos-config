{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];
  perSystem = {pkgs, ...}: {
    devshells.default = {
      packages = with pkgs; [
        alejandra
        nixd
      ];
      commands = [
        {
          name = "rs";
          help = "Nixos rebuild switch";
          command = "nixos-rebuild switch --flake .#$1";
        }
        {
          name = "rt";
          help = "Nixos rebuild test";
          command = "nixos-rebuild test --flake .#$1";
        }
        {
          name = "fmt";
          help = "Run nix code formatter, currently alejandra.";
          command = "alejandra .";
        }
      ];
    };
  };
}
