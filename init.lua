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

-- Setup Lazy - The plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
