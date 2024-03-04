return {
    {
        mode = "n",
        "<leader>tt",
        desc = "nvim-tree: Find file",
        function()
            require("nvim-tree.api").tree.find_file({ open = true, focus = true })
        end,
    },
}
