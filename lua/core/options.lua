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

-- Enable true colors and transparency support
vim.o.termguicolors = true
vim.o.background = "dark"

-- Set transparent background for various UI elements
local function set_transparent_bg()
    local groups = {
        'Normal', 'NormalFloat', 'NormalNC', 'SignColumn',
        'EndOfBuffer', 'LineNr', 'Folded', 'VertSplit',
        'StatusLine', 'StatusLineNC', 'TabLine', 'TabLineFill'
    }
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end
end

-- Apply transparency when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_transparent_bg
})

-- Apply transparency immediately
set_transparent_bg()

-- Window and popup menu transparency
opt.winblend = 15        -- Window transparency (0-100)
opt.pumblend = 15        -- Popup menu transparency (0-100)
