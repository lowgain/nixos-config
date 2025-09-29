{flake, ...}: {
  imports = [
    flake.inputs.nvf.homeManagerModules.default
    ./mappings
    ./plugins
    ./options.nix
  ];
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    enableManpages = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      preventJunkFiles = true;
      clipboard.enable = true;
      clipboard.providers.wl-copy.enable = true;
      spellcheck = {
        enable = true;
        languages = ["en"];
      };

      enableLuaLoader = true;
      globals.editorconfig = true;
      lsp.enable = true;
    };
  };
}
