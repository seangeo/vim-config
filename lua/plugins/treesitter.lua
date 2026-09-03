return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers =
      { "lua", "vim", "vimdoc", "query", "html", "regex", "bash", "rust", "typescript", "tsx", "javascript", "sql", "elixir", "heex", "eex" }

    require("nvim-treesitter").install(parsers)

    -- indent is skipped for sql: its treesitter indent query is unreliable, fall back to vim's built-in indent
    local filetypes = {
      lua = "lua",
      vim = "vim",
      help = "vimdoc",
      query = "query",
      html = "html",
      sh = "bash",
      rust = "rust",
      typescript = "typescript",
      typescriptreact = "tsx",
      javascript = "javascript",
      sql = false,
      elixir = "elixir",
      heex = "heex",
      eex = "eex",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = vim.tbl_keys(filetypes),
      callback = function(args)
        local lang = filetypes[vim.bo[args.buf].filetype]
        vim.treesitter.start(args.buf, lang or nil)
        if lang ~= false then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
