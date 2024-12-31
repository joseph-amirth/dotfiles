return {
  {
    "lewis6991/gitsigns.nvim",
    name = "gitsigns",
    config = function()
      require("gitsigns").setup {
        on_attach = function()
          -- To allow heirline to render the git component without any action.
          vim.api.nvim_create_autocmd("User", {
            pattern = "GitSignsUpdate",
            callback = function()
              vim.cmd "redrawstatus"
            end,
          })
        end,
      }
    end,
  },
}
