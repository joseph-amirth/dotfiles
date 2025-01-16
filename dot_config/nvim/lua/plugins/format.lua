return {
  {
    "stevearc/conform.nvim",
    name = "formatter",
    event = "VeryLazy",
    config = function()
      -- TODO: Ensure formatters are installed.

      local prettier_formatting = { "prettierd", "prettier", stop_after_first = true }

      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = prettier_formatting,
          javascriptreact = prettier_formatting,
          typescript = prettier_formatting,
          typescriptreact = prettier_formatting,
          json = prettier_formatting,
          markdown = { "mdformat" },
          rust = { lsp_format = "fallback" },
          cpp = { "clang-format", stop_after_first = true },
          kotlin = { "ktfmt" },
          ocaml = { "ocamlformat" },
        },
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format { bufnr = args.buf }
        end,
      })
    end,
  },
}
