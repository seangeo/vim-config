return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
    -- elixir: with both elixirls and expert attached (see languageservers.lua),
    -- prefer expert's documentSymbol response -- it includes full
    -- pattern-matched function heads, where elixirls only gives plain names.
    lsp = {
      priority = { expert = 20 },
    },
    layout = {
      default_direction = "right",
      min_width = 30,
    },
  },
  keys = {
    { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Aerial (outline)" },
  },
}
