return {
  {
    "mhartington/formatter.nvim",
    config = function()
      -- TODO: Ensure formatters are installed.

      require("formatter").setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          javascript = {
            require("formatter.filetypes.javascript").prettier,
          },
          javascriptreact = {
            require("formatter.filetypes.javascriptreact").prettier,
          },
          typescript = {
            require("formatter.filetypes.typescript").prettier,
          },
          typescriptreact = {
            require("formatter.filetypes.typescriptreact").prettier,
          },
          json = {
            require("formatter.filetypes.json").prettier,
          },
        },
      }

      vim.cmd [[
                augroup FormatAutogroup
                    autocmd!
                    autocmd BufWritePost * FormatWrite
                augroup END
            ]]

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        callback = function()
          vim.lsp.buf.format {
            filter = function(client)
              return client.name ~= "tsserver"
            end,
            async = false,
          }
        end,
      })
    end,
  },
}
