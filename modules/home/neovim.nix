{
  flake.homeModules.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = with pkgs; [
        nixd
        alejandra
        lua-language-server
      ];
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = "${builtins.readFile ./nvim/plugin/lsp.lua}";
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = "${builtins.readFile ./nvim/plugin/treesitter.lua}";
        }
        {
          plugin = comment-nvim;
          config = "require(\"Comment\").setup()";
        }
        {
          plugin = lualine-nvim;
          config = "require(\"lualine\").setup()";
        }
        {
          plugin = telescope-nvim;
          config = "${builtins.readFile ./nvim/plugin/telescope.lua}";
        }
        telescope-fzf-native-nvim
        blink-cmp
        vim-nix
        nvim-web-devicons
      ];
      initLua = ''
        ${builtins.readFile ./nvim/options.lua}
      '';
    };
  };
}
