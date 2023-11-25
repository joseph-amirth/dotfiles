-- TODO: Ensure formatters are installed.

local util = require("formatter.util")

require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        javascript = {
            require("formatter.filetypes.javascriptreact").prettier,
        },
    },
})

vim.cmd([[
    augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
    augroup END
]])

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
