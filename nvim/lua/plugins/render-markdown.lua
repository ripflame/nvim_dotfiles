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
				render_modes = true,
			})

			-- Set custom background color for code blocks (Everforest medium bg1)
			vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#343F44" })
		end,
	},
}
