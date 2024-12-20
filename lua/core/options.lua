-- Core Neovim options and settings
local opt = vim.opt
local g = vim.g

-- Set to true if you have a Nerd Font installed
g.have_nerd_font = false

-- Line numbers
opt.number = true
-- opt.relativenumber = true

-- Mouse
opt.mouse = 'a'

-- Clipboard
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

vim.wo.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Editor UI
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.wrap = false           -- Disable line wrap
opt.termguicolors = true   -- Enable 24-bit RGB colors
opt.colorcolumn = '80'     -- Show a column at 80 characters

-- Display
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10

-- File handling
opt.undofile = true

-- Set transparency
vim.opt.winblend = 15  -- Window transparency (0-100)
vim.opt.pumblend = 15  -- Popup menu transparency (0-100)

-- If you're using Neovim 0.8+ and want background transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
