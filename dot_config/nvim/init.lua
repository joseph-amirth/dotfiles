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
vim.lsp.enable({ "clangd", "lua_ls", "rust_analyzer" })

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

-- Set up syntax highlighting with treesitter (from kickstart.nvim)
do
  vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
  })

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if the buffer is valid (might not be after install completes)
    if not vim.api.nvim_buf_is_valid(buf) then return end
  
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end
  
    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)
  
    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'
  
    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
  
    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end
  
  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match
  
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end
  
      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'
  
      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--------------------------------------------------------------------------------
-- Git-related settings.
--------------------------------------------------------------------------------

vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim",
})

local gitsigns = require('gitsigns')
vim.keymap.set("n", "gb", gitsigns.blame)
vim.keymap.set("n", "gl", gitsigns.blame_line)
