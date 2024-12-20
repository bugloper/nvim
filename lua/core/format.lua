-- Formatting configuration
local format_is_enabled = true
vim.api.nvim_create_user_command('ToggleFormat', function()
  format_is_enabled = not format_is_enabled
  print('Format on save: ' .. tostring(format_is_enabled))
end, {})

local function format()
  if not format_is_enabled then
    return
  end
  
  local buf = vim.api.nvim_get_current_buf()
  
  vim.lsp.buf.format({
    bufnr = buf,
    filter = function(client)
      -- Never request formatting from these servers
      local blocked_servers = {
        ['sumneko_lua'] = true,
        ['lua_ls'] = true,
      }
      
      -- If the server is blocked, don't use it to format
      if blocked_servers[client.name] then
        return false
      end
      
      -- Check if the client supports formatting
      return client.supports_method('textDocument/formatting')
    end
  })
end

-- Create an autocommand for format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('AutoFormat', { clear = true }),
  callback = format,
})

-- Export the format function
return {
  format = format,
}
