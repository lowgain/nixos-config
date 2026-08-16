{
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
        configure = {
          customLuaRC = ''
            vim.opt.relativenumber = true
            vim.opt.number = true
            vim.opt.colorcolumn = "80"
            vim.opt.cursorline = true
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.expandtab = true
            vim.opt.softtabstop = 2
            vim.opt.list = true
            vim.opt.listchars = 'tab:▸▸,trail:•'
            vim.opt.sidescrolloff = 10
            vim.opt.scrolloff = 10
            vim.g.mapleader = " "
          '';
        };
      };
    };
  };
}
