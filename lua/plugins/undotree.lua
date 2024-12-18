return {
    "mbbill/undotree",
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" }
    },
    config = function()
        -- Undotree configuration
        vim.g.undotree_WindowLayout = 2  -- Layout style (2 is on the right side)
        vim.g.undotree_ShortIndicators = 1  -- Use short indicators
        vim.g.undotree_SplitWidth = 30  -- Width of the undotree window
        vim.g.undotree_DiffpanelHeight = 10  -- Height of the diff panel
        vim.g.undotree_SetFocusWhenToggle = 1  -- Focus on undotree when toggled
        vim.g.undotree_TreeNodeShape = "●"  -- Tree node shape
        vim.g.undotree_TreeVertShape = "│"  -- Vertical shape
        vim.g.undotree_TreeSplitShape = "╱"  -- Split shape
        vim.g.undotree_TreeReturnShape = "╲"  -- Return shape
        vim.g.undotree_DiffCommand = "diff"  -- External diff command
        vim.g.undotree_RelativeTimestamp = 1  -- Use relative timestamps
        vim.g.undotree_HighlightChangedText = 1  -- Highlight changed text
        vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"  -- Syntax highlight for additions
        vim.g.undotree_HighlightSyntaxChange = "DiffChange"  -- Syntax highlight for changes
        vim.g.undotree_HighlightSyntaxDel = "DiffDelete"  -- Syntax highlight for deletions
    end,
}
