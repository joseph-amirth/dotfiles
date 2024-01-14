return {
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {},
        config = function()
            local hop = require("hop")
            hop.setup({})

            vim.keymap.set("n", "<leader>ja", hop.hint_anywhere)
            vim.keymap.set("n", "<leader>jw", hop.hint_words)
            vim.keymap.set("n", "<leader>jj", function()
                hop.hint_anywhere({ current_line_only = true })
            end)
        end,
    },
}
