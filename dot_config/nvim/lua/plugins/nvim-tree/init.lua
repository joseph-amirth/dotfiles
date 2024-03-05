return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
        view = {
            relativenumber = true,
        },
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
    keys = require("plugins.nvim-tree.keys"),
}
