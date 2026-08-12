{
  flake.homeModules.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      initLua = ''
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.expandtab = true
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.cursorline = true
      '';
      coc.enable = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        # oil-nvim
        auto-pairs
        # comment-nvim
        vim-airline
        # conform-nvim
        vim-nix
      ];
    };

    home.packages = with pkgs; [
      nixd
      alejandra
    ];
  };
}
