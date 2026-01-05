-- Minimal init.lua
-- Load core configurations
require('core.options')
require('core.keymaps')
require('core.autocmds')
require('core.floaminal')  -- Load floating terminal
require('core.format')     -- Load format configuration

-- Bootstrap and configure lazy.nvim
require('core.lazy')
require('lazy').setup({
  -- Load plugin specifications from separate files
  { import = 'plugins' },  -- This will load all files in lua/plugins/*.lua
  { import = 'bugloper.plugins' },  -- Load bugloper plugin configurations
}, require('core.lazy'))   -- Load lazy.nvim configuration

require("mason").setup({
  ui = {
    border = "rounded",
    winblend = 0, -- Set to 0 for full opacity
  }
})


vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[
      highlight NormalFloat guibg=#000000
      highlight FloatBorder guibg=#000000
      set winhighlight=NormalFloat:Normal,FloatBorder:Normal
    ]]
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "harpoon",
  callback = function()
    vim.cmd [[
      highlight NormalFloat guibg=#000000
      highlight FloatBorder guibg=#000000
      set winhighlight=NormalFloat:Normal,FloatBorder:Normal
    ]]
  end,
})

