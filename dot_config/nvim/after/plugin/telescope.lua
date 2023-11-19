-- Ensure ripgrep is installed.
if vim.fn.executable("rg") ~= 1 then
    -- TODO: Figure out how to get sudo to work in the below command.
    vim.fn.system({ "sudo", "pacman", "-S", "--noconfirm", "ripgrep" })
end

local telescope = require("telescope")

telescope.load_extension("dotfiles")

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
