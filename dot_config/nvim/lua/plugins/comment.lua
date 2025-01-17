return {
  {
    {
      "numToStr/Comment.nvim",
      event = "VeryLazy",
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup {
            enable_autocmd = false,
          }
        end,
      },
      config = function()
        require("Comment").setup {
          pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
          toggler = {
            line = "<C-/>",
          },
          opleader = {
            line = "<leader>/",
          },
          extra = {
            -- Add comment on the line above.
            above = "<leader>/O",
            -- Add comment on the line below.
            below = "<leader>/o",
            -- Add comment at the end of line.
            eol = "<leader>/A",
          },
        }
      end,
    },
  },
}
