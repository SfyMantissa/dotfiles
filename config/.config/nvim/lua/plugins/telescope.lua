return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local b = require("telescope.builtin")
            local t = require("telescope")
            vim.keymap.set("n", "<leader>ff", b.find_files)
            vim.keymap.set("n", "<leader>fr", t.extensions.repo.list)
            vim.keymap.set("n", "<leader>fg", b.live_grep)
            vim.keymap.set("n", "<leader>fb", b.buffers)
            vim.keymap.set("n", "<leader>fh", b.help_tags)
        end,
    },
    {
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
