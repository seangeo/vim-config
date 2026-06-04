-- Rust-specific key mappings for rustacean.nvim
local bufnr = vim.api.nvim_get_current_buf()

-- Enhanced hover with actions (replaces default K)
vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({'hover', 'actions'})
end, { silent = true, buffer = bufnr, desc = "Rust hover with actions" })

-- Code actions
vim.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp('codeAction')
end, { silent = true, buffer = bufnr, desc = "Rust code actions" })

-- Run runnables
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd.RustLsp('runnables')
end, { silent = true, buffer = bufnr, desc = "Rust runnables" })

-- Debug
vim.keymap.set("n", "<leader>rd", function()
  vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = bufnr, desc = "Rust debuggables" })

-- Expand macro
vim.keymap.set("n", "<leader>rm", function()
  vim.cmd.RustLsp('expandMacro')
end, { silent = true, buffer = bufnr, desc = "Rust expand macro" })

-- Open Cargo.toml
vim.keymap.set("n", "<leader>rc", function()
  vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = bufnr, desc = "Open Cargo.toml" })

-- Parent module
vim.keymap.set("n", "<leader>rp", function()
  vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = bufnr, desc = "Parent module" })

-- Join lines
vim.keymap.set("n", "<leader>rj", function()
  vim.cmd.RustLsp('joinLines')
end, { silent = true, buffer = bufnr, desc = "Join lines" })

-- Enhanced error viewing
vim.keymap.set("n", "<leader>re", function()
  require("trouble").toggle("diagnostics", { filter = { buf = 0 } })
end, { silent = true, buffer = bufnr, desc = "Rust errors (Trouble)" })

-- View all project errors
vim.keymap.set("n", "<leader>rE", function()
  require("trouble").toggle("diagnostics")
end, { silent = true, buffer = bufnr, desc = "All project errors" })

-- Enhanced hover for error explanations
vim.keymap.set("n", "<leader>rh", function()
  vim.diagnostic.open_float({
    scope = "cursor",
    focusable = true,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  })
end, { silent = true, buffer = bufnr, desc = "Show error details" })

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = bufnr,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
