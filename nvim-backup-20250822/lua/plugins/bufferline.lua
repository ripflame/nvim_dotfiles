return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        separator_style = "padded_slant",
        diagnostics = "nvim_lsp",
      }
    })
  end
}