return {
	{
		-- Highlighting, autoidenting
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		-- Hightlighting for different brace levels
		"HiPhish/nvim-ts-rainbow2",
		config = function()
			-- Set stuff for rainbow braces
			local config = require("nvim-treesitter.configs")
			config.setup({
				rainbow = {
					enable = true,
					disable = { "jsx", "cpp" },
					query = "rainbow-parens",
					strategy = require("ts-rainbow").strategy.global,
				},
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
