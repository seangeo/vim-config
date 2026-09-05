return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "expert", "vtsls", "eslint", "sqls" },
        -- mason-lspconfig v2 auto-enables every installed Mason package that has a
        -- matching lspconfig entry. stylua is installed as a *formatter* (see none-ls)
        -- but lspconfig ships a `stylua` server spec running `stylua --lsp`, which the
        -- 2.x CLI does not support -- it crashed on every lua buffer. Keep it excluded.
        automatic_enable = { exclude = { "stylua", "stylua3p_ls" } },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities({labelDetailsSupport = false})

      -- Servers are configured with the native vim.lsp API (the legacy
      -- require("lspconfig") framework is deprecated and will be removed in
      -- nvim-lspconfig v3). The "*" config applies to every server.
      vim.lsp.config("*", { capabilities = capabilities })

      -- sqls: use a project-local .sqls.yaml for connection config when present.
      vim.lsp.config("sqls", {
        root_markers = { ".sqls.yaml", "config.yml", ".git" },
        -- Note: on nvim 0.11 the cmd function only receives dispatchers (the
        -- resolved config is not passed in), so the root is re-derived here.
        cmd = function(dispatchers)
          local cmd = { "sqls" }
          local root = vim.fs.root(0, { ".sqls.yaml", "config.yml", ".git" })
          local sqls_config = root and (root .. "/.sqls.yaml")
          if sqls_config and vim.fn.filereadable(sqls_config) == 1 then
            cmd = { "sqls", "-config", sqls_config }
          end
          return vim.lsp.rpc.start(cmd, dispatchers)
        end,
      })

      -- TypeScript / JavaScript via vtsls. Formatting is left to prettier
      -- (none-ls), so vtsls's own formatter is disabled on attach to avoid
      -- competing formatters on <leader>F / format-on-save.
      vim.lsp.config("vtsls", {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })

      -- ESLint diagnostics with fix-on-save. The autocmd is registered per
      -- buffer on attach so it only runs in projects where eslint is present.
      -- The default on_attach must be chained because it creates the
      -- LspEslintFixAll command.
      local eslint_on_attach = vim.lsp.config.eslint.on_attach
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          if eslint_on_attach then
            eslint_on_attach(client, bufnr)
          end
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "LspEslintFixAll",
          })
        end,
      })

      vim.lsp.enable({ "lua_ls", "csharp_ls", "expert", "sqls", "vtsls", "eslint" })

      -- Configure enhanced diagnostics display
      vim.diagnostic.config({
        virtual_text = {
          enabled = true,
          source = "if_many",
          prefix = "●", -- Could be '●', '▎', 'x', '■', etc.
          spacing = 4,
          format = function(diagnostic)
            -- Limit line length and add source
            local message = diagnostic.message:gsub("\n", " ")
            if #message > 50 then
              message = message:sub(1, 47) .. "..."
            end
            return string.format("%s [%s]", message, diagnostic.source or "rust")
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "»",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          format = function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source or "rust")
          end,
        },
      })

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostics (loclist)" })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          --vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to dec" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to def" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show docs" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
          --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf })
          --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf })
          --vim.keymap.set('n', '<space>wl', function()
          --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          --end, { buffer = ev.buf })
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Type Definition" })
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            { buffer = ev.buf, desc = "Code Actions" }
          )
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "References" })
          vim.keymap.set("n", "<leader>F", function()
            vim.lsp.buf.format({ async = true })
          end, { buffer = ev.buf, desc = "Format" })
        end,
      })
    end,
  },
}
