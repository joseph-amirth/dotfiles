return {
	{
		mode = "n",
		"<leader>tt",
		desc = "nvim-tree: Toggle find file",
		function()
			-- require("nvim-tree.api").tree.find_file({ open = true, focus = true })
			require("nvim-tree.api").tree.toggle { find_file = true, open = true, focus = true }
		end,
	},
}
