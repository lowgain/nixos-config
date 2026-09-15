{
  flake.homeModules.lowgainNeovim = {
    pkgs,
    lib,
    ...
  }: {
    home.sessionVariables.EDITOR = "nvim";
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        nixd
        lua-language-server
      ];
      initLua = builtins.readFile ./nvim/init.lua;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./nvim/lua/plugins/lsp.lua;
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./nvim/lua/plugins/treesitter.lua;
        }
        {
          plugin = mini-pick;
          type = "lua";
          config = ''require("mini.pick").setup()'';
        }
        vim-nix
        {
          plugin = everforest;
          type = "lua";
          config = ''
            vim.cmd.colorscheme("everforest")
            vim.g.everforest_enable_italic = true
            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
          '';
        }
      ];
    };
  };
}
