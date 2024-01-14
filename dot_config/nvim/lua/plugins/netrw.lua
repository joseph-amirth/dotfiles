return {
    {
        "prichrd/netrw.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("netrw").setup({
                icons = {
                    symlink = "",
                    directory = "",
                    file = "",
                },
                use_devicons = true, -- Use nvim-web-devicons
            })

            vim.keymap.set("n", "<leader>tt", vim.cmd.Ex)
        end,
    },
}
