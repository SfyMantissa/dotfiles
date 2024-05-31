return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "echasnovski/mini.animate",
        version = "*",
        config = function()
            require("mini.animate").setup()
        end,
    },
    {
        "nanozuki/tabby.nvim",
        event = "VimEnter",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("tabby.tabline").use_preset("tab_with_top_win", {
                nerdfont = true,
                lualine_theme = "dracula",
                tab_name = {
                    name_fallback = function(tabid)
                        return tabid
                    end,
                },
                buf_name = {
                    mode = "unique",
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "dracula",
                },
            })
        end,
    },
}
