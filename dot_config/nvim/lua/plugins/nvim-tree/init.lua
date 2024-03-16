return {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    event = "VeryLazy",
    opts = {
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        view = {
            relativenumber = true,
            width = 35,
        },
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
    keys = require("plugins.nvim-tree.keys"),
}
