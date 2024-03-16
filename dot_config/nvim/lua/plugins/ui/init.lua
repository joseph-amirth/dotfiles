return {
  {
    {
      "glepnir/dashboard-nvim",
      name = "dashboard",
      event = "VimEnter",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "telescope",
      },
      opts = {
        theme = "doom",
        config = {
          header = require("plugins.ui.dashboard").header,
          center = {
            {
              icon = "  ",
              desc = "Find file",
              key = "f",
              action = "Telescope find_files",
            },
            {
              icon = "  ",
              desc = "New file",
              key = "n",
              action = "enew",
            },
            {
              icon = "  ",
              desc = "Recent files",
              key = "o",
              action = "Telescope oldfiles",
            },
            {
              icon = "  ",
              desc = "Find text",
              key = "g",
              action = "Telescope live_grep",
            },
            {
              icon = "  ",
              desc = "dotfiles",
              key = "d",
              action = "Telescope dotfiles",
            },
            {
              icon = "󱓍  ",
              desc = "Plugins",
              key = "p",
              action = "Lazy",
            },
            {
              icon = "󰗼  ",
              desc = "Quit",
              key = "q",
              action = "qa",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local padding = string.rep("\n", 1)
            local footer = padding
                .. "⚡ Neovim loaded "
                .. stats.loaded
                .. "/"
                .. stats.count
                .. " plugins in "
                .. ms
                .. "ms"
            return vim.split(footer, "\n")
          end,
        },
      },
      config = function(_, opts)
        for _, option in ipairs(opts.config.center) do
          option.desc = option.desc .. string.rep(" ", 43 - #option.desc)
          option.key_format = "  %s"
        end
        require("dashboard").setup(opts)
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },
}
