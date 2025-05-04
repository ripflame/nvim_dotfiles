---------------------------------------------------------------------------------------------------
-- PLUGINS CONFIGURATION
---------------------------------------------------------------------------------------------------

return {
  -- UI Enhancements
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'medium'
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme('everforest')
    end
  },
  -- Lua
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Bufferline setup
  {
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
  },

  -- Development Tools
  { "folke/neodev.nvim", opts = {} },

  -- File Navigation
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
  },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        actions = {
          open_file = {
            quit_on_open = true, -- Close nvim-tree after opening a file
          },
        },
      }
    end,
  },

  -- LSP & Autocompletion
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 100,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-e>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-q>'] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = 'nvim_lsp_signature_help' },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            local icons = {
              nvim_lsp = "",
              luasnip = "",
              buffer = "",
              path = "",
            }
            vim_item.kind = string.format("%s %s", icons[entry.source.name] or "?", vim_item.kind)
            return vim_item
          end,
        },
      })
    end
  },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      local snippets_path = vim.fn.expand("~/.nvim-setup/nvim/snippets")
      require("luasnip.loaders.from_snipmate").lazy_load({
        paths = snippets_path,
        fs_event_providers = { "libuv" }
      })
    end,
  },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {}
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },

  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    opts = {}
  },

  -- Autopairs & Commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {}
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  -- Syntax Highlighting & Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
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
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
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

  -- Formatting & Linting
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "html", "css", "json" },
            extra_args = { "--print-width", "100" },
          }),
        },
      })
    end,
  },

  -- Code Folding & Structure
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    event = "BufReadPost",
    opts = {
      open_fold_hl_timeout = 0,
      close_fold_kinds = {},
      provider_selector = function(bufnr, filetype, _)
        -- Force indent for known problematic filetypes
        local force_indent = { html = true, xml = true }

        if force_indent[filetype] then
          return { "indent" }
        end

        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        for _, client in ipairs(clients) do
          if client.server_capabilities and client.server_capabilities.foldingRangeProvider then
            return { "lsp", "indent" } -- Use LSP if available
          end
        end

        return { "indent" } -- Fallback to indent if no LSP folding
      end
    }
  },

  -- Code Context
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

  -- Visual Guides
  {
    "lukas-reineke/virt-column.nvim",
    event = "BufReadPost",
    opts = {
      char = "│",
      highlight = "VertSplit"
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
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
}
