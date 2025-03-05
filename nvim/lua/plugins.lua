return {
  -- UI Enhancements
  -- lazy
  {
    "askfiy/visual_studio_code",
    priority = 100,
    config = function()
      vim.cmd([[colorscheme visual_studio_code]])
    end,
  },
  -- TokyoNight Theme
  --  {
  --    "folke/tokyonight.nvim",
  --    lazy = false,   -- load at startup
  --    priority = 1000, -- load this plugin before others
  --    config = function()
  --      vim.cmd("colorscheme tokyonight-storm")
  --    end,
  --  },
  -- Edge theme
  --  {
  --    'sainnhe/edge',
  --    lazy = false,
  --    priority = 1000,
  --    config = function()
  --      -- Optionally configure and load the colorscheme
  --      -- directly inside the plugin declaration.
  --      -- Set Edge theme configuration options before loading the theme
  --      vim.g.edge_style = 'aura'
  --      vim.g.edge_better_performance = 1
  --      vim.g.edge_enable_italic = true
  --      vim.cmd.colorscheme('edge')
  --    end
  --  },
  --  everforest theme
  --  {
  --    'sainnhe/everforest',
  --    lazy = false,
  --    priority = 1000,
  --    config = function()
  --      -- Optionally configure and load the colorscheme
  --      -- directly inside the plugin declaration.
  --      vim.g.everforest_background = 'dark'
  --      vim.g.everforest_enable_italic = true
  --      vim.cmd.colorscheme('everforest')
  --    end
  --  },
  { "folke/neodev.nvim" },

  -- File Navigation
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP & Autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
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

  -- nvim-treesitter: Advanced syntax highlighting, indentation, and incremental selection.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "javascript", "typescript", "lua", "python", "html", "css" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",   -- Start selection
            node_incremental = "grn", -- Expand selection
            scope_incremental = "grc",
            node_decremental = "grm", -- Shrink selection
          },
        },
      }
    end
  },

  -- vim-polyglot: A collection of language packs and filetype plugins.
  -- It enhances filetype detection and provides language-specific settings.
  { "sheerun/vim-polyglot" },

  -- Lualine configuration
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
