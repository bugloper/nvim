return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows
        day_brightness = 0.3,         -- Adjusts the brightness of the colors of the **Day** style
        hide_inactive_statusline = false,
        dim_inactive = false,         -- dims inactive windows
        lualine_bold = false,        -- When `true`, section headers in the lualine theme will be bold
      })

      -- Load the colorscheme
      vim.cmd[[colorscheme tokyonight-night]]
    end,
  },
}
