-- Git blame views (window pane or virtual text) powered by `git blame`.
-- Lazy-loaded: only pulled in on the BlameToggle command or the keymaps below.

return {
  {
    'FabijanZulj/blame.nvim',
    cmd = 'BlameToggle',
    keys = {
      { '<leader>gb', '<cmd>BlameToggle window<cr>', desc = 'Git [b]lame (window)' },
      { '<leader>gv', '<cmd>BlameToggle virtual<cr>', desc = 'Git blame ([v]irtual text)' },
    },
    opts = {
      date_format = '%Y-%m-%d',
      relative_date_if_recent = true,
      virtual_style = 'right_align',
      -- Jump into the blame pane when it opens so the mappings below work right away
      focus_blame = true,
      -- Collapse runs of lines from the same commit into a single entry
      merge_consecutive = true,
      max_summary_width = 40,
      -- Where <CR> opens the full commit diff
      commit_detail_view = 'vsplit',
      mappings = {
        commit_info = 'i',
        stack_push = '<TAB>',
        stack_pop = '<BS>',
        show_commit = '<CR>',
        close = { '<esc>', 'q' },
        copy_hash = 'y',
        open_in_browser = 'o',
      },
    },
    config = function(_, opts)
      require('blame').setup(opts)
    end,
  },
}
