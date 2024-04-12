vim.opt.clipboard:append("unnamedplus")
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.cmdheight = 2
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.ruler = true
vim.opt.switchbuf = "useopen"
vim.opt.scrolloff = 3
vim.opt.completeopt = { "menu", "noinsert", "noselect", "preview" }
vim.opt.shortmess:append("c")

vim.g.mapleader = ","
vim.keymap.set("n", "\\", ":nohl<CR>", { silent = true })
vim.keymap.set("c", "%%", "<C-R>=expand('%:h').'/'<cr>")
vim.keymap.set("n", "<LEADER><LEADER>", "<C-^>")
vim.keymap.set("n", "<LEADER>e", ":edit %%", { remap = true })
vim.keymap.set("n", "<C-j>", "<C-W>j", {})
vim.keymap.set("n", "<C-k>", "<C-W>k", {})
vim.keymap.set("n", "<C-h>", "<C-W>h", {})
vim.keymap.set("n", "<C-l>", "<C-W>l", {})
vim.keymap.set("n", "<C-Down>", "<C-W>j", {})
vim.keymap.set("n", "<C-Up>", "<C-W>k", {})
vim.keymap.set("n", "<C-Left>", "<C-W>h", {})
vim.keymap.set("n", "<C-Right>", "<C-W>l", {})
