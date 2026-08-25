{inputs, ...}: {
  flake.nixosModules.nvf = {pkgs, ...}: {
    imports = [
      inputs.nvf.nixosModules.default
    ];

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = false;
        vimAlias = true;
        theme = {
          enable = true;
          name = "everforest";
          style = "soft";
          transparent = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspkind.enable = true;
          otter-nvim.enable = true;
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.blink-cmp.enable = true;
        git.enable = true;
        snippets.luasnip.enable = true;
        spellcheck.enable = true;
        formatter.conform-nvim = {
          enable = true;
          presets = {
            alejandra.enable = true;
            black.enable = true;
            dockerfmt.enable = true;
            gawk.enable = true;
            jsonfmt.enable = true;
            prettier.enable = true;
            shfmt.enable = true;
            stylua.enable = true;
            superhtml.enable = true;
          };
        };
        ui = {
          smartcolumn.enable = true;
        };
        undoFile.enable = true;
        utility = {
          csvview.enable = true;
          preview.glow.enable = true;
          snacks-nvim.enable = true;
          undotree.enable = true;
        };
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        clipboard.enable = true;
        comments.comment-nvim.enable = true;
        options = {
          tabstop = 2;
          shiftwidth = 2;
          wrap = false;
        };
        languages = {
          enableTreesitter = true;
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          awk.enable = true;
          bash.enable = true;
          css.enable = true;
          docker.enable = true;
          html.enable = true;
          json.enable = true;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python.enable = true;
          toml.enable = true;
          yaml.enable = true;
        };
      };
    };
    stylix = {
      targets.nvf = {
        enable = false;
      };
    };
  };
}
