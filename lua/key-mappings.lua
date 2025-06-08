vim.g.mapleader = ","

local mappings = {
  ["%%"] = { "n", "<C-R>=expand('%:h').'/'<cr>", { desc = "Directory of current file" } },
  ["<LEADER><LEADER>"] = { "n", "<C-^>", {} },
  ["<LEADER>e"] = { "n", ":edit %%", { remap = true } },
  ["<ESC>"] = { "t", "<C-\\><C-n>", { desc = "Exit insert mode in terminal" } },

  -- Splits
  ["<LEADER>s"] = { "n", "<C-W><C-S>", { desc = "Create new horizonal split" } },
  ["<LEADER>v"] = { "n", "<C-W><C-V>", { desc = "Create new vertical split" } },
  ["<Down>"] = { {"n", "v"}, "<C-W>j", { desc = "Move down a split" } },
  ["<Up>"] = { {"n", "v"}, "<C-W>k", { desc = "Move up a split" } },
  ["<Left>"] = { {"n", "v"}, "<C-W>h", { desc = "Move left a split" } },
  ["<Right>"] = { {"n", "v"}, "<C-W>l", { desc = "Move right a split" } },
  ["≤"] = { "n", ":vertical resize -5<CR>", { silent = true }},
  ["≥"] = { "n", ":vertical resize +5<CR>", { silent = true }},
  ["±"] = { "n", ":resize +5<CR>", { silent = true }},
  ["—"] = { "n", ":resize -5<CR>", { silent = true }},
  ["≠"] = { "n", "<C-W>=", { silent = true }},
}

local function map(mode, key, result, opts)
  opts = opts or {}
  vim.keymap.set(mode, key, result, opts)
end

for key, value in pairs(mappings) do
  map(value[1], key, value[2], value[3])
end
