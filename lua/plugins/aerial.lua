return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
    layout = {
      default_direction = "right",
      min_width = 30,
    },
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Aerial (outline)" },
  },
}
