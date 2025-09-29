{
  programs.nvf.settings.vim.ui = {
    noice.enable = true;
    colorizer.enable = true;
    modes-nvim.enable = false;
    illuminate.enable = true;
    breadcrumbs = {
      enable = true;
      source = "nvim-navic";
      navbuddy.enable = false;
    };
    smartcolumn = {
      enable = true;
      setupOpts = {
        columnAt.languages = {
          markdown = [80];
          html = [120];
          css = [80];
          nix = [120];
          go = [120];
          ts = [120];
        };
      };
    };
  };
}
