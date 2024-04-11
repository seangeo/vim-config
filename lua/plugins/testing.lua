return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "Issafalcon/neotest-dotnet",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet"),
      },
    })

    vim.keymap.set("n", "<leader>m", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run tests in current file" })

    vim.keymap.set("n", "<leader>M", function()
      require("neotest").run.run()
    end, { desc = "Run nearests tests" })

    vim.keymap.set("n", "<leader>a", function()
      require("neotest").run.run({ suite = true })
    end, { desc = "Run all tests" })

    vim.keymap.set("n", "<leader>To", function()
      require("neotest").output_panel.toggle()
    end, { desc = "Toggle test output panel" })

    vim.keymap.set("n", "<leader>Ts", function()
      require("neotest").summary.toggle()
    end, { desc = "Toggle test summary panel" })
  end,
}
