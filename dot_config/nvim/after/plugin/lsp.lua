local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'rust_analyzer',
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end)

lsp.skip_server_setup({
    'rust_analyzer',
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.setup()

-- rust-tools setup

local rust_tools = require('rust-tools')

rust_tools.setup({
    server = {
        on_attach = function()
            vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
        end
    }
})
