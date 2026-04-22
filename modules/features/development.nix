{self, ...}: {
  flake.nixosModules.development = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git-remote-gcrypt
    ];
    programs.git = {
      enable = true;
      config = {
        user = {
          name = self.name;
          email = self.email;
          signingkey = "A29A2526E1AECD911F6D4EDA65852671ADE357CC";
        };
      };
    };

    programs.direnv = {
      enable = true;
      silent = true;
    };
  };
}
