return {
	{
		-- Fuzzy finding files
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local b = require("telescope.builtin")
			local t = require("telescope")
			vim.keymap.set("n", "<leader>ff", t.extensions.file_browser.file_browser)
			vim.keymap.set("n", "<leader>fr", t.extensions.repo.list)
			vim.keymap.set("n", "<leader>fg", b.live_grep)
			vim.keymap.set("n", "<leader>fb", b.buffers)
			vim.keymap.set("n", "<leader>fh", b.help_tags)
		end,
	},
	{
		-- Replace some native NeoVim windows with Telescope selectors.
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					file_browser = {
						theme = "ivy",
						hijack_netrw = true,
						mappings = {
							["i"] = {},
							["n"] = {},
						},
					},
				},
			})
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"cljoly/telescope-repo.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					repo = { list = { search_dirs = { "~/repos/" } } },
				},
			})
			require("telescope").load_extension("repo")
		end,
	},
}
