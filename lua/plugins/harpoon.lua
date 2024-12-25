return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",  -- Using Harpoon v2
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      -- REQUIRED
      harpoon:setup()
      -- Basic keymaps
      local keymap = vim.keymap.set
      -- Harpoon mark and UI controls
      keymap("n", "<leader>a", function() harpoon:list():add() end,
        { desc = "Harpoon: Add file" })
      keymap("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Harpoon: Toggle quick menu" })
      -- Navigation
      keymap("n", "<C-k>", function() harpoon:list():select(1) end,
        { desc = "Harpoon: Go to file 1" })
      keymap("n", "<C-l>", function() harpoon:list():select(2) end,
        { desc = "Harpoon: Go to file 2" })
      keymap("n", "<C-n>", function() harpoon:list():select(3) end,
        { desc = "Harpoon: Go to file 3" })
      keymap("n", "<C-s>", function() harpoon:list():select(4) end,
        { desc = "Harpoon: Go to file 4" })
      -- Toggle previous & next buffers stored within Harpoon list
      keymap("n", "<C-S-P>", function() harpoon:list():prev() end,
        { desc = "Harpoon: Go to previous mark" })
      keymap("n", "<C-S-N>", function() harpoon:list():next() end,
        { desc = "Harpoon: Go to next mark" })
    end,
  },
}
