return {
  "Eutrius/Otree.nvim",
  lazy = false,
  dependencies = {
    "stevearc/oil.nvim",
  },
  config = function()
    require("Otree").setup({
      git_signs = true,
      lsp_signs = true,
    })
    vim.keymap.set("n", "<leader>E", "<cmd>Otree<cr>", { desc = "Toggle file tree" })
  end,
}
