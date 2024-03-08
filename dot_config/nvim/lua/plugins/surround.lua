return {
    {
        "kylechui/nvim-surround",
        name = "surround",
        version = "*",
        event = "VeryLazy",
        opts = {
            keymaps = {
                normal = "s",
                normal_line = "S",
                normal_cur = "ss",
                normal_cur_line = "SS",
                visual = "s",
                visual_line = "S",
            },
        },
        config = function(_, opts)
            require("nvim-surround").setup(opts)
        end,
    },
}
