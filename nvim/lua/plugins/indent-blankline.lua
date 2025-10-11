return {
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
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#eb6f92" })      -- love
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f6c177" })   -- gold
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#31748f" })     -- pine
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ebbcba" })   -- rose
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9ccfd8" })    -- foam
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#c4a7e7" })   -- iris
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#9ccfd8" })     -- foam (cyan)
    end)

    require("ibl").setup {
      indent = { highlight = highlight },
      exclude = {
        filetypes = { "markdown", "text", "gitcommit", "help", "man", "rst", "asciidoc", "org" }
      }
    }
  end
}