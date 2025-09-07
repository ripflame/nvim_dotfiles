return {
  "mbbill/undotree",
  config = function()
    vim.g.undotree_WindowLayout = 2           -- Undotree left, diff bottom
    vim.g.undotree_DiffAutoOpen = 1           -- Auto-open diff panel
    vim.g.undotree_DiffpanelHeight = 10       -- Set height for diff panel
    vim.g.undotree_SetFocusWhenToggle = 1     -- Focus undotree when opened
    vim.g.undotree_HighlightChangedText = 1   -- Highlight changed text
    vim.g.undotree_HighlightChangedWithSign = 1 -- Show change signs in gutter
    
    -- Note: In undotree window:
    -- j/k = move cursor only (no diff update)
    -- J/K = move cursor AND update diff (this is what you want!)
    -- <Enter> = switch to that undo state
  end,
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
}