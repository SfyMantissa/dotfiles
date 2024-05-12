return {
	"dimasriat/gecko.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local gecko = require("gecko")
		vim.keymap.set("n", "<leader>fc", function()
			gecko:find_coin()
		end, { desc = "Invoke Gecko to find coin details" })
	end,
}

