return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  config = function()
    local snippets_path = vim.fn.expand("~/.nvim-setup/nvim/snippets")
    require("luasnip.loaders.from_snipmate").lazy_load({
      paths = snippets_path,
      fs_event_providers = { "libuv" }
    })
  end,
  keys = function()
    return {
      {
        "<Tab>",
        function()
          local ls = require("luasnip")
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
            -- If not in a snippet, behave like a normal tab
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
          end
        end,
        mode = { "i", "s" },
        desc = "Expand snippet or jump to next tabstop"
      },
      {
        "<S-Tab>",
        function()
          local ls = require("luasnip")
          if ls.jumpable(-1) then
            ls.jump(-1)
          else
            -- If not in a snippet, behave like a normal shift-tab
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
          end
        end,
        mode = { "i", "s" },
        desc = "Jump to previous tabstop"
      },
    }
  end,
}