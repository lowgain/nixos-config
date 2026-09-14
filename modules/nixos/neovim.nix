{self, ...}: {
  flake.nixosModules.neovim = {
    options,
    lib,
    ...
  }: {
    config = lib.mkMerge [
      {
        programs.neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          defaultEditor = true;
          configure.customLuaRC = ''
            vim.o.tabstop = 2
            vim.o.shiftwidth = 2
            vim.o.expandtab = true
            vim.o.number = true
            vim.o.relativenumber = true
            vim.o.signcolumn = "yes"
            vim.o.wrap = false
            vim.o.swapfile = false
            vim.o.autoindent = true
            vim.o.smartindent = true
            vim.o.winborder = "rounded"

            vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
            vim.cmd(":hi statusline guibg=NONE")
          '';
        };
      }
      (lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [self.homeModules.neovim];
      })
    ];
  };
}
