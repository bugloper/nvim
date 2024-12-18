-- Core keymaps configuration
local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- File explorer
keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Move lines up and down with auto-formatting
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better join lines (keeps cursor in place)
keymap("n", "J", "mzJ`z", { desc = "Join lines and keep cursor" })

-- Better scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search terms in the middle
keymap("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Greatest remap ever - paste without yanking
keymap("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Next greatest remap ever - system clipboard
keymap({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to void register
keymap({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Escape from insert mode
keymap("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

-- Disable Ex mode
keymap("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- LSP formatting
keymap("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })

-- Quickfix navigation
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

-- Search and replace current word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 
    { desc = "Search and replace current word" })

-- Clear search highlights
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Clear search highlights" })

-- Window navigation
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
