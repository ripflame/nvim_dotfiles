return {
  -- Mason LSP package manager
  {
    "mason-org/mason.nvim"
  },
  
  -- Mason integration with lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
}