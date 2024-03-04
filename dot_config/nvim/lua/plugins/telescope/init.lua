return {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("dotfiles")
    end,
    keys = require("plugins.telescope.keys"),
}
