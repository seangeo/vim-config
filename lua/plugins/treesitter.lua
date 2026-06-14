return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "query", "html", "regex", "bash", "rust", "typescript", "tsx", "javascript", "sql" },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "sql" },
      },
      indent = { enable = true, disable = { "sql" } },
    })
  end,
}
