local function keys_helper(key, desc, fn)
    return {
        mode = "n",
        key,
        desc = "Hop to " .. desc,
        function()
            local hop = require("hop")
            fn(hop)
        end,
    }
end

return {
    {
        "smoka7/hop.nvim",
        version = "*",
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("hop").setup(opts)
        end,
        keys = {
            keys_helper("<leader>jj", "anywhere in line", function(hop)
                hop.hint_anywhere({ current_line_only = true })
            end),
            keys_helper("<leader>jw", "any word", function(hop)
                hop.hint_words()
            end),
            keys_helper("<leader>ja", "anywhere", function(hop)
                hop.hint_anywhere()
            end),
        },
    },
}
