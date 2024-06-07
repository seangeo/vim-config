-- Enable system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Tab setting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Indenting
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Ignore case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cmdheight = 2

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable window titles
vim.opt.title = true

-- Enable cursor line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- Enable line and column ruler
vim.opt.ruler = true
vim.opt.switchbuf = "useopen"

-- Better scrolling experience
vim.opt.scrolloff = 6

-- Autocomplete behaviour
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "preview" }
vim.opt.shortmess:append("c")

-- 24bit Gui colors
vim.opt.termguicolors = true

-- Enable the sign column
vim.opt.signcolumn = "yes"

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
