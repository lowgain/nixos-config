{ flake, ... }:

let
  inherit (flake) inputs;
in
{
  imports = [ inputs.nvf.nixosModules.default ];
  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = false;
      vim.vimAlias = false;
    };
  };
}
