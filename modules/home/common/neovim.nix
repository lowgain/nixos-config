{
  flake,
  lib,
  ...
}:

let
  inherit (flake) inputs;
in
{
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf.enable = true;
  programs.nvf.settings = {
    vim = {
      theme = {
        enable = true;
        name = lib.mkForce "gruvbox";
        style = "light";
      };
      options = {
        shiftwidth = 4;
        tabstop = 4;
      };
      lsp.enable = true;
      languages = {
        nix.enable = true;
        enableTreesitter = true;
      };
      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      ui.smartcolumn.enable = true;
      ui.smartcolumn.setupOpts.colorcolumn = "80";
    };
  };
}
