return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason",
      "mason-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

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

          map("gr", function()
            require("telescope.builtin").lsp_references()
          end, "[G]oto [R]eferences")

          map("gd", function()
            require("telescope.builtin").lsp_definitions()
          end, "[G]oto [D]efinition")

          map("gi", function()
            require("telescope.builtin").lsp_implementations()
          end, "[G]oto [I]mplementations")

          map("gD", vim.lsp.buf.definition, "[G]oto [D]eclaration")

          map("<leader>D", function()
            require("telescope.builtin").lsp_type_definitions()
          end, "Type [D]efinition")

          map("<leader>ds", function()
            require("telescope.builtin").lsp_document_symbols()
          end, "[D]ocument [S]ymbols")

          map("<leader>ws", function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols()
          end, "[W]orkspace [S]ymbols")

          map("K", vim.lsp.buf.hover, "Hover documentation")

          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    name = "mason",
    event = "VeryLazy",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    name = "mason-lspconfig",
    event = "VeryLazy",
    opts = {
      ensure_installed = { "lua_ls", "bashls" },
    },
  },
}
