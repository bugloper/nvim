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

-- Display
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
opt.scrolloff = 10

-- File handling
opt.undofile = true