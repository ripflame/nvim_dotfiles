return {
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
        { name = "lazydev",                group_index = 0 },
        { name = "nvim_lsp" },
        { name = 'nvim_lsp_signature_help' },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = function(entry, vim_item)
          local icons = {
            nvim_lsp = "",
            luasnip = "",
            buffer = "",
            path = "",
            lazydev = "󰒲",
          }
          vim_item.kind = string.format("%s %s", icons[entry.source.name] or "?", vim_item.kind)
          return vim_item
        end,
      },
    })
  end
}