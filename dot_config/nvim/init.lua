--------------------------------------------------------------------------------
-- Editing-related settings.
--------------------------------------------------------------------------------

-- Translate 1 tab to 4 spaces.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

-- Limit line length to width of console in VGA mode.
vim.opt.textwidth = 80

-- Install package to add/change/delete surrounding pairs.
vim.pack.add({
	"https://github.com/kylechui/nvim-surround",
})

--------------------------------------------------------------------------------
-- Navigation-related settings.
--------------------------------------------------------------------------------

-- Set up line numbers for easy line jumping.
vim.opt.number = true
vim.opt.relativenumber = true

-- Quickfix list mappings.
vim.keymap.set("n", "co", vim.cmd.copen)
vim.keymap.set("n", "cx", vim.cmd.cclose)

-- Remap escape to do nothing in normal mode.
vim.keymap.set("n", "<Esc>", "<Nop>")

--------------------------------------------------------------------------------
-- LSP-related settings.
--------------------------------------------------------------------------------

-- Install default configs for LSPs.
vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
})

-- Enable select LSPs.
vim.lsp.enable({ "clangd", "lua_ls" })

-- Configure LSP completion.
vim.cmd([[set completeopt+=menuone,noselect,popup]])

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- Install mapping to trigger LSP completion.
vim.keymap.set("i", "<c-space>", function()
	vim.lsp.completion.get()
end)

--------------------------------------------------------------------------------
-- Appearance-related settings.
--------------------------------------------------------------------------------

-- Install and set color scheme.
vim.pack.add({
	"https://github.com/catppuccin/nvim",
})

vim.cmd.colorscheme("catppuccin-macchiato")

-- Enable treesitter highlighting for C.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function(ev)
		vim.treesitter.start(ev.buf, "c")
	end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
