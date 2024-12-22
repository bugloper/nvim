-- Floating terminal configuration
local M = {}

-- Store terminal buffer ID
M.term_buf = nil
-- Store terminal window ID
M.term_win = nil

-- Calculate dimensions for 80% of window size
local function get_dimensions()
  local width = math.floor(vim.api.nvim_get_option("columns") * 0.8)
  local height = math.floor(vim.api.nvim_get_option("lines") * 0.8)
  
  -- Calculate starting position to center the window
  local row = math.floor((vim.api.nvim_get_option("lines") - height) / 2)
  local col = math.floor((vim.api.nvim_get_option("columns") - width) / 2)
  
  return {
    width = width,
    height = height,
    row = row,
    col = col
  }
end

function M.open_terminal()
  local dims = get_dimensions()
  
  -- If terminal buffer exists but window doesn't, create new window
  if M.term_buf and vim.api.nvim_buf_is_valid(M.term_buf) then
    -- Create new window
    M.term_win = vim.api.nvim_open_win(M.term_buf, true, {
      relative = "editor",
      width = dims.width,
      height = dims.height,
      row = dims.row,
      col = dims.col,
      style = "minimal",
      border = "rounded"
    })
    
    -- Set window options
    vim.wo[M.term_win].winblend = 10
    vim.wo[M.term_win].winhl = "Normal:Normal"
  else
    -- Create new buffer
    M.term_buf = vim.api.nvim_create_buf(false, true)
    
    -- Create window
    M.term_win = vim.api.nvim_open_win(M.term_buf, true, {
      relative = "editor",
      width = dims.width,
      height = dims.height,
      row = dims.row,
      col = dims.col,
      style = "minimal",
      border = "rounded"
    })
    
    -- Set window options
    vim.wo[M.term_win].winblend = 10
    vim.wo[M.term_win].winhl = "Normal:Normal"
    
    -- Start terminal in buffer
    vim.fn.termopen(vim.o.shell)
  end
  
  -- Enter insert mode
  vim.cmd('startinsert')
end

function M.close_terminal()
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_win_close(M.term_win, true)
    M.term_win = nil
  end
end

function M.toggle_terminal()
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    M.close_terminal()
  else
    M.open_terminal()
  end
end

function M.clear_terminal()
  if M.term_buf and vim.api.nvim_buf_is_valid(M.term_buf) then
    -- Get the terminal channel ID
    local chan = vim.b[M.term_buf].terminal_job_id
    if chan then
      -- Clear the screen and reset cursor position
      vim.api.nvim_chan_send(chan, [[clear && printf '\033[3J\033[H']])
      -- Force a redraw of the screen
      vim.cmd('redraw!')
    end
  end
end

-- Set up keymaps
vim.keymap.set('n', '<leader>ff', M.toggle_terminal, { noremap = true, silent = true, desc = 'Toggle floating terminal' })
-- Add escape keymap for terminal mode to easily close the terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = M.term_buf, desc = 'Exit terminal mode' })
-- Add clear terminal keymap (Cmd+k or Ctrl+k)
vim.keymap.set('t', '<D-k>', function() M.clear_terminal() end, { noremap = true, silent = true, desc = 'Clear terminal' })
vim.keymap.set('t', '<C-k>', function() M.clear_terminal() end, { noremap = true, silent = true, desc = 'Clear terminal' })

return M
