vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Use CTRL+<[]> or CTRL+<1-9> to switch between tabs
for i = 1, 9 do
	vim.keymap.set("n", string.format("<C-%d>", i), string.format("<cmd>%dtabnext<cr>", i), { desc = string.format("Move to the %dth tab", i) })
end
vim.keymap.set("n", "<C-]>", "<cmd>tabnext<cr>", { desc = "Move focus to the next tab" })
vim.keymap.set("n", "<C-[>", "<cmd>tabprevious<cr>", { desc = "Move focus to the previous tab" })
