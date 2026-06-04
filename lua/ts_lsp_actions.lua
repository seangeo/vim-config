-- Shared buffer-local keymaps for TypeScript/JavaScript buffers.
-- These expose the vtsls source-action refactors that the generic LSP
-- mappings don't reach. Loaded from the after/ftplugin/* files for each
-- of the ts/tsx/js/jsx filetypes.
local M = {}

function M.setup()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Apply a single source-action kind directly, without the picker.
  local function map(lhs, kind, desc)
    vim.keymap.set("n", lhs, function()
      vim.lsp.buf.code_action({
        context = { only = { kind }, diagnostics = {} },
        apply = true,
      })
    end, { silent = true, buffer = bufnr, desc = desc })
  end

  map("<leader>to", "source.organizeImports", "TS: organize imports")
  map("<leader>ta", "source.addMissingImports.ts", "TS: add missing imports")
  map("<leader>tu", "source.removeUnused.ts", "TS: remove unused")
  map("<leader>tf", "source.fixAll.ts", "TS: fix all")
end

return M
