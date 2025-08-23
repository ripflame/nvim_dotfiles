return {
  -- Main treesitter plugin
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "markdown", "javascript", "typescript", "lua", "python", "html", "css" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        matchup = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }
    end
  },

  -- Treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    opts = {
      enable = true,
      max_lines = 4,
      min_window_height = 1,
      mode = "cursor",
      separator = "─",
    }
  },
}