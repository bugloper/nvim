-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    -- Initialize nvim-web-devicons for file icons
    require('nvim-web-devicons').setup()

    -- Configure neo-tree with icons enabled
    require('neo-tree').setup({
      filesystem = {
        window = {
          width = 30,
          mappings = {
            ['\\'] = 'close_window',
          },
          winhighlight = "Normal:NeoTreeNormal,FloatBorder:NeoTreeWinSeparator",
        },
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      default_component_configs = {
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            added = '✚',
            modified = '●',
            deleted = '✖',
            renamed = '➜',
            untracked = '?',
            ignored = '◌',
            unstaged = '✗',
            staged = '✓',
            conflict = '⚠',
          },
        },
      },
    })

    -- Customize Neo-tree colors after colorscheme loads
    local function setup_neotree_colors()
      -- Neo-tree window background
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#000000", fg = "#cdd6f4" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#000000", fg = "#cdd6f4" })
      vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#000000", fg = "#000000" })
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "#000000", fg = "#1e1e2e" })
      
      -- Neo-tree cursor line
      vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#1e1e2e" })
      
      -- Neo-tree file icons
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#cdd6f4" })
      vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#cdd6f4" })
      
      -- Neo-tree git status colors
      vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#a6e3a1" })
      vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#f9e2af" })
      vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#f38ba8" })
      vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#f38ba8" })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = setup_neotree_colors,
    })

    -- Apply colors immediately if colorscheme is already loaded
    vim.defer_fn(function()
      setup_neotree_colors()
    end, 100)
  end,
}
