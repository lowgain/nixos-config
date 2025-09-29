{pkgs, ...}: let
  inherit (pkgs.vimPlugins) undotree direnv-vim mkdir-nvim;
in {
  programs.nvf.settings.vim.extraPlugins = {
    direnv = {package = direnv-vim;};
    mkdir-nvim = {package = mkdir-nvim;};
    undotree = {package = undotree;};
  };
}
