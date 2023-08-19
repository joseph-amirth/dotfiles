require("Comment").setup({
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
})
