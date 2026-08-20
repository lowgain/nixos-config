if vim.fn.has('nvim-0.11') == 1 and vim.lsp.config then
  vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  })
end

vim.lsp.config("nixd", {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.<hostname>.options',
        },
        home_manager = {
          expr = '(builtins.getFlake (toString ./.)).homeConfigurations."<username>@<hostname>".options',
        },
      },
    },
  },
})
vim.lsp.enable("nixd")

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
})
vim.lsp.enable('lua_ls')
