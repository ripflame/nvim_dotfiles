return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim",
		},
		config = function()
			require("render-markdown").setup({
				code = {
					language_border = " ",
					highlight = "RenderMarkdownCode",
				},
				render_modes = { "n", "c", "t" },
				pipe_table = { cell = "trimmed" },
				completions = { lsp = { enabled = true } },
				-- anti_conceal = { enabled = false },
			})
		end,
	},
}
