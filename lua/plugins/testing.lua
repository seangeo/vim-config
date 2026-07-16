return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "Issafalcon/neotest-dotnet",
    "jfpedroza/neotest-elixir",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet"),
        require("neotest-elixir"),
        require("rustaceanvim.neotest"),
      },
    })

    -- Clear the output panel before each run so it only shows the latest
    -- results. Watch-mode re-runs bypass this; use <leader>Tc for those.
    local function run_tests(args)
      local neotest = require("neotest")
      neotest.output_panel.clear()
      neotest.run.run(args)
    end

    -- In an Elixir lib module, run its conventional test file instead
    -- (lib/foo.ex -> test/foo_test.exs), so doctests can be run while
    -- editing the module. Test files and other languages run as-is.
    vim.keymap.set("n", "<leader>m", function()
      local file = vim.fn.expand("%:p")
      if file:match("/lib/.*%.ex$") then
        local test_file = file:gsub("/lib/", "/test/", 1):gsub("%.ex$", "_test.exs")
        if vim.fn.filereadable(test_file) == 1 then
          file = test_file
        else
          vim.notify("No matching test file: " .. test_file, vim.log.levels.WARN)
          return
        end
      end
      run_tests(file)
    end, { desc = "Run tests in current file" })

    vim.keymap.set("n", "<leader>M", function()
      run_tests()
    end, { desc = "Run nearest tests" })

    vim.keymap.set("n", "<leader>a", function()
      run_tests({ suite = true })
    end, { desc = "Run all tests" })

    vim.keymap.set("n", "<leader>Tc", function()
      require("neotest").output_panel.clear()
    end, { desc = "Clear test output panel" })

    vim.keymap.set("n", "<leader>To", function()
      require("neotest").output_panel.toggle()
    end, { desc = "Toggle test output panel" })

    vim.keymap.set("n", "<leader>Ts", function()
      require("neotest").summary.toggle()
    end, { desc = "Toggle test summary panel" })
  end,
}
