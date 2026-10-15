return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function ()
      require("neogit").setup({})

      vim.keymap.set("n", "<leader>G", require("neogit").open, { desc = "Open Neogit" })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(buf)
          local gs = require("gitsigns")
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end, "Next hunk")
          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end, "Previous hunk")

          map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
          map("v", "<leader>gs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Stage selected lines")
          map("v", "<leader>gr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Reset selected lines")
          map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
          map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
          end, "Blame line")
        end,
      })

      -- Review changes made outside nvim (e.g. by Claude Code)
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: working tree" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: file history" })
      vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Diffview: close" })
    end,
  },
  "tpope/vim-fugitive"
}
