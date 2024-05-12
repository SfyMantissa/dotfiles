return {
	{
		-- Separate install for dependency of the next plugin.
		"vhyrro/luarocks.nvim",
		priority = 1101,
		opts = {
			rocks = { "magick" },
		},
	},
	{
		-- Separe install for image rendering.
		"3rd/image.nvim",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("image").setup({
				max_width = 78,
				max_height_window_percentage = nil,
			})
		end,
	},
}
