return {
  {
    "Bekaboo/dropbar.nvim",
    name = "dropbar",
    dependencies = { "fzf", "icons" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree",
    dependencies = { "icons" },
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
    keys = {
      {
        mode = "n",
        "<leader>tt",
        desc = "nvim-tree: Toggle find file",
        function()
          require("nvim-tree.api").tree.toggle { find_file = true, open = true, focus = true }
        end,
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    name = "icons",
  },
}
