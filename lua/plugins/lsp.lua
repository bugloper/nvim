return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('bugloper-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Key mappings for LSP
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Highlight references
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Helper function to replace root_pattern
      local function root_pattern(...)
        local patterns = { ... }
        return function(fname)
          -- Handle buffer number or file path
          local file_path = fname
          if type(fname) == 'number' then
            file_path = vim.api.nvim_buf_get_name(fname)
            if file_path == '' then
              -- If buffer has no file, use current working directory
              return vim.fn.getcwd()
            end
          end
          
          -- Ensure we have a valid string path
          if type(file_path) ~= 'string' or file_path == '' then
            return vim.fn.getcwd()
          end
          
          local path = vim.fs.dirname(file_path)
          if not path or path == '' then
            return vim.fn.getcwd()
          end
          
          local found = vim.fs.find(patterns, { path = path, upward = true })[1]
          if found and type(found) == 'string' then
            return vim.fs.dirname(found)
          end
          return path
        end
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        ruby_lsp = {
          cmd = { "ruby-lsp" },
          filetypes = { "ruby" },
          root_dir = root_pattern(".git", "."),
        },
        gopls = {
          cmd = { "gopls" },
          filetypes = { "go", "gomod" },
          root_dir = root_pattern("go.mod", ".git"),
        },
      }

      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',        -- Lua formatter
        'prettier',      -- JavaScript/TypeScript/CSS/HTML formatter
        'black',         -- Python formatter
        'clang-format',  -- C/C++ formatter
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(server_name, server)
            vim.lsp.enable(server_name)
          end,
        },
      }

      -- Manually set up `ruby-ls` and `gopls`
      vim.lsp.config('ruby_lsp', servers.ruby_lsp)
      vim.lsp.enable('ruby_lsp')
      vim.lsp.config('gopls', servers.gopls)
      vim.lsp.enable('gopls')
    end,
  },
}
