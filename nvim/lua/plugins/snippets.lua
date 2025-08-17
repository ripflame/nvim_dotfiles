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
}