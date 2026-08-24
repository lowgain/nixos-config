{
  flake.homeModules.shell = {pkgs, ...}: {
    home = {
      packages = with pkgs; [
        git-remote-gcrypt
        tldr
      ];
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
    };

    programs = {
      bash.enable = true;
      tmux = {
        enable = true;
        keyMode = "vi";
      };
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
      git = {
        enable = true;
        lfs.enable = true;
        maintenance.enable = true;
      };
    };
  };
}
