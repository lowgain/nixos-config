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
      useSystemClipboard = true;
      spellcheck = {
        enable = true;
        languages = ["en"];
      };

      enableLuaLoader = true;
      enableEditorconfig = true;
    };
  };
}
