return {
  {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    dependencies = { { "nvim-lua/plenary.nvim", "fzf" } },
    opts = {},
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension "dotfiles"
      telescope.load_extension "fzf"
    end,
    keys = require "plugins.telescope.keys",
    cmd = "Telescope",
  },
  { "nvim-telescope/telescope-fzf-native.nvim", name = "fzf", event = "VeryLazy", build = "make" },
}
