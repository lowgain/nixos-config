{
  flake.nixosModules.neovim = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ripgrep
      nixd
      alejandra
      lua-language-server
    ];
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      runtime = {
        "plugin/lsp.lua".source = ./nvim/plugin/lsp.lua;
        "plugin/mini.lua".source = ./nvim/plugin/mini.lua;
        "plugin/treesitter.lua".source = ./nvim/plugin/treesitter.lua;
        "plugin/everforest.lua".source = ./nvim/plugin/everforest.lua;
        "plugin/options.lua".source = ./nvim/plugin/options.lua;
      };
      configure = {
        packages.default = with pkgs.vimPlugins; {
          start = [
            nvim-lspconfig
            (nvim-treesitter.withPlugins (p: [
              p.nix
              p.bash
              p.lua
              p.toml
              p.yaml
            ]))
            mini-pick
            # mini-pairs
            mini-basics
            mini-completion
            mini-icons
            everforest
          ];
        };
      };
    };
  };
}
