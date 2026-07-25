{self, ...}: {
  flake.nixosModules.shell = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wget
      vim
    ];

    programs = {
      git.enable = true;
      tmux = {
        enable = true;
        keyMode = "vi";
      };
      neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
    };
  };
}
