return {
  -- UI Enhancements
  {
    "askfiy/visual_studio_code",
    priority = 100,
    config = function()
      vim.cmd([[colorscheme visual_studio_code]])
    end,
  },
  -- TokyoNight Theme
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,   -- load at startup
  --   priority = 1000, -- load this plugin before others
  --   config = function()
  --     vim.cmd("colorscheme tokyonight-storm")
  --   end,
  -- },
  -- Edge theme
  -- {
  --   'sainnhe/edge',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     -- Set Edge theme configuration options before loading the theme
  --     vim.g.edge_style = 'aura'
  --     vim.g.edge_better_performance = 1
  --     vim.g.edge_enable_italic = true
  --     vim.cmd.colorscheme('edge')
  --   end
  -- },
  -- Everforest theme
  -- {
  --   'sainnhe/everforest',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.everforest_background = 'dark'
  --     vim.g.everforest_enable_italic = true
  --     vim.cmd.colorscheme('everforest')
  --   end
  -- },
  { "folke/neodev.nvim" },

  -- File Navigation
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP & Autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "L3MON4D3/LuaSnip" },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    config = function()
      require("diffview").setup()
    end
  },

  -- Autopairs & Commenting
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
  { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end },

  -- Syntax Highlighting & Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "javascript", "typescript", "lua", "python", "html", "css" },
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

  -- Lualine (Status Line)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 2 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Null-ls (Formatting & Linting)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "html", "css", "json" }
          }),
        },
      })
    end,
  },
}
