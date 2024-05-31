return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                ["<leader>q"] = {
                    name = "Quit/Close",
                    ["q"] = { "Window" },
                    ["c"] = { "Buffer" },
                },
                ["<leader>w"] = { "Write" },
                ["ZS"] = { "Write" },
                ["<leader><leader>"] = { "Unhighlight Text" },
                ["<leader>n"] = { "Toggle Line Numbers" },
                ["<leader>b"] = { "Toggle Columnline" },
                ["<leader>h"] = { "Horizontal Split" },
                ["<leader>v"] = { "Vertical Split" },
                ["<leader>e"] = { "Explore Filesystem" },
                ["<leader>t"] = { "Terminal" },
                ["<leader>p"] = { "<cmd>Lazy<cr>", "Plugins" },
                ["<leader>l"] = {
                    name = "LSP",
                    ["i"] = { "Info" },
                    ["a"] = { "Actions" },
                    ["m"] = { "Mason" },
                    ["f"] = { "Format" },
                    ["h"] = { "Hover" },
                    ["d"] = { "Definition" },
                    ["r"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
                    ["l"] = {
                        function()
                            local float = vim.diagnostic.config().float

                            if float then
                                local config = type(float) == "table" and float or {}
                                config.scope = "line"
                                vim.diagnostic.open_float(config)
                            end
                        end,
                        "Diagnostics",
                    },
                },
                ["<leader>g"] = {
                    name = "Git",
                    ["b"] = { "Blame" },
                    ["c"] = { "Commit" },
                    ["j"] = { "Next Hunk" },
                    ["k"] = { "Previous Hunk" },
                    ["p"] = { "Preview Hunk" },
                    ["l"] = { "Log" },
                    ["r"] = { "Reset Hunk" },
                    ["s"] = { "Stage Hunk" },
                    ["u"] = { "Unstage Hunk" },
                },
                ["<leader>f"] = {
                    name = "Find",
                    ["l"] = { "<cmd>Telescope oldfiles<cr>", "Last Files" },
                    ["f"] = { "Files" },
                    ["g"] = { "Lines" },
                    ["r"] = { "Repos" },
                    ["b"] = { "Buffers" },
                    ["h"] = { "Help Pages" },
                    ["c"] = { "Cryptocurrencies" },
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },
}
