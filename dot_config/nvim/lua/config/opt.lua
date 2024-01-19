-- Line number settings for easy line jumping.
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab settings: 1 tab = 4 spaces.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Disables long lines from wrapping around.
vim.opt.wrap = false

-- Disables showing mode on last line.
vim.opt.showmode = false

-- Enables 24-bit RGB color in the TUI.
vim.opt.termguicolors = true

-- Always enables sign column.
vim.opt.signcolumn = "yes"

vim.opt.pumheight = 20

local function tab_size_2(filetypes)
    for _, filetype in ipairs(filetypes) do
        vim.cmd("autocmd FileType " .. filetype .. " setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")
    end
end

tab_size_2({ "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "cpp" })
