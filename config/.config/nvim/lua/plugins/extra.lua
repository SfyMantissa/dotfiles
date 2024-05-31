return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1101,
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        config = function()
            require("image").setup({
                max_width = 78,
                max_height_window_percentage = nil,
            })
        end,
    },
    {
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
    },
    {
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
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })
        end,
    },
}
