return {
  {
    "hedyhli/outline.nvim",
    opts = {
      outline_window = {
        width = 20,
        position = "left",
        show_numbers = true,
        show_relative_numbers = true,
        winhl = "Normal:StatusLine",
        auto_close = true,
      },
      symbol_folding = {
        autofold_depth = false,
      },
    },
    keys = {
      {
        "<leader>oo",
        "<cmd>Outline<CR>",
        desc = "Toggle outline",
      },
    },
  },
}
