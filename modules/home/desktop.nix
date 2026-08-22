{self, ...}: {
  flake.homeModules.desktop = {pkgs, ...}: {
    imports = [
      self.homeModules.browsers
    ];
    programs = {
      mpv.enable = true;
      w3m.enable = true;
      btop.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      bat.enable = true;
      zoxide.enable = true;
      lazygit.enable = true;
      eza.enable = true;
      qalculate.enable = true;
      pay-respects.enable = true;
      gh.enable = true;
      starship = {
        enable = true;
      };
      fzf = {
        enable = true;
        tmux.enableShellIntegration = true;
      };
      lf.enable = true;
      direnv = {
        enable = true;
        silent = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
    };
    home.packages = with pkgs; [
      tldr
    ];
    xdg = {
      userDirs.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "qutebrowser.desktop";
          "x-scheme-handler/http" = "qutebrowser.desktop";
          "x-scheme-handler/https" = "qutebrowser.desktop";
          "x-scheme-handler/about" = "qutebrowser.desktop";
          "x-scheme-handler/unknown" = "qutebrowser.desktop";
          "inode/directory" = "lf.desktop";
        };
      };
    };
  };
}
