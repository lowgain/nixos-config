vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.relativenumber = true
vim.o.scrolloff = 2
vim.o.sidescroll = 1
vim.o.sidescrolloff = 2
vim.o.smartindent = false

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ff", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>h", "<Cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>ts", "<Cmd>set spell!<CR>")
