require('nvim-treesitter').setup {
  ensure_installed = { "lua", "nix" },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
}
