return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local mason_lspconfig = require "mason-lspconfig"
			mason_lspconfig.setup {
				ensure_installed = { "lua_ls", "bashls" },
			}
			mason_lspconfig.setup_handlers {
				function(server_name)
					if server_name == "tsserver" then
						server_name = "ts_ls"
					end
					require("lspconfig")[server_name].setup { capabilities = capabilities }
				end,
			}

			require("lspconfig").lua_ls.setup {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			}

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					local function map(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations")
					map("gD", vim.lsp.buf.definition, "[G]oto [D]eclaration")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

					map("K", vim.lsp.buf.hover, "Hover documentation")

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		name = "mason",
		opts = {},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{ "folke/neodev.nvim", name = "neodev", opts = {} },
}
