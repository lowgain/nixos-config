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

      direnv = {
        enable = true;
        silent = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };

      tmux = {
        enable = true;
        keyMode = "vi";
      };

      starship = {
        enable = true;
      };

      fzf = {
        enable = true;
        tmux.enableShellIntegration = true;
      };
    };
  };
}
