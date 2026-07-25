{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.noctalia-greeter = {pkgs, ...}: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];
    programs.noctalia-greeter = {
      enable = true;
      greeter-args = "";
      settings = {
        cursor = {
          theme = "Bibata-Modern-Amber";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "us";
        };
        appearance.password_style = "random";
      };
    };
  };
}
