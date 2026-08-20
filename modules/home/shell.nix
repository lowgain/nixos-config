{self, ...}: {
  flake.homeModules.shell = {pkgs, ...}: {
    imports = [
      self.homeModules.git
      self.homeModules.neovim
    ];

    home.packages = with pkgs; [
      git-remote-gcrypt
    ];

    programs = {
      bash.enable = true;
      tmux = {
        enable = true;
        keyMode = "vi";
      };
    };
  };
}
