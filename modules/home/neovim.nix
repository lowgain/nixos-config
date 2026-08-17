{
  flake.homeModules.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      initLua = ''
        vim.opt.relativenumber = true
        vim.opt.number = true
        vim.opt.colorcolumn = "80"
        vim.opt.cursorline = true
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        vim.opt.softtabstop = 2
        vim.opt.list = true
        vim.opt.listchars = 'tab:>>,trail:•'
        vim.opt.sidescrolloff = 10
        vim.opt.scrolloff = 10
        vim.opt.wrap = false
        vim.g.mapleader = " "
        vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none"})
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none"})
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
