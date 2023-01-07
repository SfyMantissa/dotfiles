--    __                        _
--   / /_ _____  ___ ______  __(_)_ _
--  / / // / _ \/ _ `/ __/ |/ / /  ' \
-- /_/\_,_/_//_/\_,_/_/  |___/_/_/_/_/

-- Vim options

---- General
vim.opt.colorcolumn = "79" -- Highlight the 79th column
vim.opt.signcolumn = "yes" -- Always display LSP/linter information
vim.opt.scrolloff = 999 -- Keep selected line in the middle
vim.opt.spelllang = "en,ru" -- Language-specific spellchecking
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.cmdheight = 2 -- Number of lines used for command prompt

---- Tabs
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- The number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert spaces for a tab

---- Indentation
vim.opt.copyindent = true -- Copy the indentation of the previous line
vim.opt.smartindent = true -- Automatically indent (e.g. after '{')

---- Long lines
vim.opt.wrap = true -- Wrap lines which exceed the screen width
vim.opt.breakindent = true -- Wrapped lines preserve indentation
vim.opt.breakindentopt = "sbr" -- "sbr" means "Show showbreak value when breakindent applies"
vim.opt.showbreak = ">>>"

---- Searching
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Match uppercase when explicitly searching for it

-- LunarVim options

---- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "lunar"
lvim.leader = "space"

---- Keybindings
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader>m"] = ":MarkdownPreviewToggle<CR>"

---- Other
lvim.lsp.automatic_servers_installation = false
lvim.builtin.illuminate.active = false
lvim.builtin.terminal.active = false
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "css",
    "yaml",
    "typescript",
    "solidity",
    "html",
    "rust",
}

-- LSP, linter, and formatter settings

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettierd",
        filetypes = { "typescript", "typescriptreact", "javacript", "css", "html" },
    },
    {
        command = "cbfmt",
        filetypes = { "markdown", "vimwiki" },
    }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {
        command = "eslint_d",
        filetypes = { "typescript", "javascript" },
    },
    {
        command = "solhint",
        filetypes = { "solidity" },
    },
    {
        command = "markdownlint",
        -- For reference:
        -- MD024: https://github.com/DavidAnson/markdownlint/blob/main/doc/md024.md
        -- MD033: https://github.com/DavidAnson/markdownlint/blob/main/doc/md033.md
        args = { "--disable", "MD024", "MD033", "--" },
        filetypes = { "markdown", "vimwiki" },
    }
}

-- Plugins
lvim.plugins = {
    { "tpope/vim-surround" },
    { "p00f/nvim-ts-rainbow" },
    {
        "karb94/neoscroll.nvim",
        require('neoscroll').setup()
    },
    {
        "norcalli/nvim-colorizer.lua",
        require('colorizer').setup()
    },
    {
        "windwp/nvim-ts-autotag",
        require('nvim-ts-autotag').setup()
    },
    {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
    },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = "markdown",
        config = function()
            vim.g.mkdp_auto_close = 0
        end
    },
    {
        "jakewvincent/mkdnflow.nvim",
        config = function()
            require('mkdnflow').setup({
                modules = {
                    bib = false,
                    buffers = false,
                    maps = true,
                },
                perspective = {
                    priority = 'root',
                    root_tell = 'index.md',
                },
                links = {
                    conceal = true,
                    transform_explicit = function(text)
                        text = text:gsub("[^%w%s]+", "");
                        text = text:gsub("%s+", "-");
                        text = text:lower();
                        return (text)
                    end
                },
                mappings = {
                    MkdnNewListItem = { 'i', '<CR>' },
                }
            })
        end
    },
}
