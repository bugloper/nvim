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
}, require('core.lazy'))   -- Load lazy.nvim configuration

require("mason").setup({
  ui = {
    border = "rounded",
    winblend = 0, -- Set to 0 for full opacity
  }
})
