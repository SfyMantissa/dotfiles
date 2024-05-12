return {
	{
        -- Granular and interactive git interaction.
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				numhl = true,
				attach_to_untracked = true,
			})
			vim.keymap.set("n", "<leader>gj", ":Gitsigns next_hunk <CR>", { silent = true })
			vim.keymap.set("n", "<leader>gk", ":Gitsigns prev_hunk <CR>", { silent = true })
			vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk <CR>", { silent = true })
			vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk <CR>", { silent = true })
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk <CR>", { silent = true })
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline <CR>", { silent = true })
		end,
	},
	{
        -- Full git wrapper.
		"tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gl", ":Git log <CR>", { silent = true })
            vim.keymap.set("n", "<leader>gb", ":Git blame <CR>", { silent = true})
            vim.keymap.set("n", "<leader>gc", ":Git commit <CR>", { silent = true})
        end
	},
}
