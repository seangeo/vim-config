-- Enable system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Remember cursor position
vim.opt.viewoptions:remove("curdir")
vim.opt.viewoptions:append("cursor,folds,slash,unix")
vim.cmd([[
  augroup remember_cursor_position
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END
]])

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

vim.g.rustfmt_autosave = 1
