return {
    {
        -- Comment automation.
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup({
                toggler = {
                    line = "<leader>cc",
                    block = "<leader>cb",
                },
                opleader = {
                    line = "<leader>cc",
                    block = "<leader>cb",
                },
                extra = {
                    above = "<leader>cp",
                    below = "<leader>cn",
                    eol = "<leader>ce",
                },
            })
        end,
    },
    {
        -- Toggle the interactive terminal.
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup()
            function _G.set_terminal_keymaps()
                vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
                vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
                vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
            end

            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
            vim.keymap.set("n", "<leader>t", ":ToggleTerm <CR>", { silent = true })
        end,
    },
}
