return {
  "jiaoshijie/undotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require('undotree').setup({
      window = {
        auto_close = true,
      },
    })
  end,
  keys = {
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
  },
}