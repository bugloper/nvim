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
          if client and client:supports_method('textDocument/documentHighlight') then
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

      local capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )

      require('mason').setup()

      -- Formatters/linters only. Language servers are handled by mason-lspconfig
      -- below. ruby-lsp is deliberately NOT installed through mason: mason bakes
      -- an absolute ruby shebang into its wrapper, which pins the server to one
      -- Ruby for every project. ruby-lsp must run on the project's own Ruby.
      require('mason-tool-installer').setup {
        ensure_installed = { 'stylua', 'prettier', 'black', 'clang-format', 'markdownlint' },
      }

      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'gopls' },
        -- ruby_lsp is configured and enabled by hand, from the project's Ruby.
        automatic_enable = { exclude = { 'ruby_lsp' } },
      }

      -- nvim 0.11 native config. mason-lspconfig v2 removed the `handlers`
      -- option, so per-server settings must go through vim.lsp.config directly.
      vim.lsp.config('*', { capabilities = capabilities })

      vim.lsp.config('lua_ls', {
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
            completion = { callSnippet = 'Replace' },
          },
        },
      })

      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod' },
        root_markers = { 'go.mod', 'go.work', '.git' },
      })

      -- No `enabledFeatures`: when it is an array, ruby-lsp treats every absent
      -- feature as DISABLED (server.rb -> Hash.new(false)). Omitting it enables
      -- everything, including "definition" -- which is what `gd` needs.
      vim.lsp.config('ruby_lsp', {
        cmd = { 'ruby-lsp' },
        filetypes = { 'ruby', 'eruby' },
        root_markers = { 'Gemfile', '.git' },
        init_options = { formatter = 'auto' },
      })

      vim.lsp.enable { 'lua_ls', 'gopls', 'ruby_lsp' }
    end,
  },
}
