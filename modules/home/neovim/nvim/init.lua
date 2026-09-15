vim.g.mapleader = " "
vim.g.maplocalleader = " m"

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ff", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>h", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>ts", "<Cmd>set spell!<CR>")

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
