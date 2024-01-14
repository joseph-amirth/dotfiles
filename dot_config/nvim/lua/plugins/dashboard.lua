return {
    {
        "glepnir/dashboard-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = " New file",
                        group = "String",
                        action = "enew",
                        key = "n",
                    },
                    {
                        desc = " Files",
                        group = "Label",
                        action = "Telescope find_files",
                        key = "f",
                    },
                    {
                        desc = " dotfiles",
                        group = "Number",
                        action = "Telescope dotfiles",
                        key = "d",
                    },
                    {
                        desc = "󱓍 Update",
                        group = "@property",
                        action = "PackerSync",
                        key = "u",
                    },
                },
            },
        },
    },
}
