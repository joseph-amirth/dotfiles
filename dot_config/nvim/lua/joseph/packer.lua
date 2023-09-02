local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerCompile
    augroup end
]])

return require("packer").startup(function(use)
    --[[ Package manager ]]
    use({ "wbthomason/packer.nvim" })

    --[[ Utility ]]

    -- Dashboard
    use({
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup()
        end,
    })

    -- File explorer
    use({ "prichrd/netrw.nvim" })

    -- Fuzzy finder for files
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    -- Statusline
    use({ "nvim-lualine/lualine.nvim" })

    -- Hop
    use({
        "phaazon/hop.nvim",
        branch = "v2",
    })

    --[[ Language Services ]]

    -- LSP configurations
    use({ "neovim/nvim-lspconfig" })

    -- LSP manager
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })

    -- Autocompletion
    use({ "hrsh7th/nvim-cmp" })

    -- Autocompletion sources
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-cmdline" })

    -- Snippet engine
    use({ "hrsh7th/cmp-vsnip" })
    use({ "hrsh7th/vim-vsnip" })

    -- Formatting
    use({ "mhartington/formatter.nvim" })

    -- Comments
    use({ "numToStr/Comment.nvim" })

    use({ "folke/neodev.nvim" })

    --[[ Aesthetics ]]

    -- Syntax highlighting
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    -- Color schemes
    use({
        "rebelot/kanagawa.nvim",
        as = "kanagawa",
    })

    -- Icons
    use({ "nvim-tree/nvim-web-devicons" })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
