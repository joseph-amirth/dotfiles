local builtin = require("telescope.builtin")

local theme = require("telescope.themes").get_dropdown({
    previewer = false,
    layout_config = {
        height = 0.5,
        width = 0.5,
    },
})

local theme_with_preview = require("telescope.themes").get_dropdown({
    preview_title = "Preview",
    layout_config = {
        height = 0.5,
        width = 0.5,
    },
})

vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files(theme)
end)
vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep(theme_with_preview)
end)
vim.keymap.set("n", "<leader>fb", function()
    builtin.buffers(theme_with_preview)
end)
vim.keymap.set("n", "<leader>fh", function()
    builtin.help_tags(theme)
end)
vim.keymap.set("n", "<leader>fd", function()
    builtin.diagnostics(theme_with_preview)
end)
vim.keymap.set("n", "<leader>fr", function()
    builtin.lsp_references(theme_with_preview)
end)
