{self, ...}: {
  flake.homeModules.desktop = {pkgs, ...}: {
    imports = [
      self.homeModules.browsers
    ];
    programs = {
      bash.enable = true;
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
    home = {
      shellAliases = {
        grep = "rg";
        ".." = "cd ..";
        "..." = "cd ...";
        cd = "z";
        find = "fd";
        cat = "bat";
        ls = "eza";
        ll = "eza -l";
        la = "eza -la";
        pr = "pay-respects";
      };
      packages = with pkgs; [
        tldr
      ];
    };
    xdg = {
      userDirs.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
          "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
          "inode/directory" = "lf.desktop";
        };
      };
    };
  };
}
