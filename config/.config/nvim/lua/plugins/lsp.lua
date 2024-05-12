return {
	{
		-- Package manager for LSPs, DAPs, linters, and formatters.
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			vim.keymap.set("n", "<leader>lm", ":Mason<CR>", { silent = true })
		end,
	},
	{
		-- Bridge between Mason and Lspconfig.
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		-- Configuration for NeoVim LSP client.
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			-- Add manually.
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.solidity_ls.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })

			vim.keymap.set("n", "<leader>li", ":LspInfo<CR>", { silent = true })
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition)
			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
		end,
	},
	{
		-- Bridge between interactive LSP functions and NeoVim.
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
                    null_ls.builtins.diagnostics.pylint,
					null_ls.builtins.diagnostics.solhint,
                    null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.formatting.prettier.with({
						filetypes = {
							"javascript",
							"typescript",
							"css",
							"scss",
							"html",
							"json",
							"yaml",
							"markdown",
							"graphql",
							"txt",
							"solidity",
						},
					}),
				},
			})
		end,
	},
}
