local function get_theme()
  return require("telescope.themes").get_dropdown {
    previewer = false,
    layout_config = {
      height = 0.5,
      width = 0.5,
    },
  }
end

local function get_theme_with_preview()
  return require("telescope.themes").get_dropdown {
    preview_title = "Preview",
    layout_config = {
      height = 0.5,
      width = 0.5,
    },
  }
end

local function keys_helper(key, desc, fn)
  return {
    mode = "n",
    key,
    desc = "Telescope: " .. desc,
    function()
      local builtin = require "telescope.builtin"
      fn(builtin)
    end,
  }
end

return {
  keys_helper("<leader>ff", "Find files", function(builtin)
    builtin.find_files(get_theme())
  end),
  keys_helper("<leader>fg", "Grep", function(builtin)
    builtin.live_grep(get_theme_with_preview())
  end),
  keys_helper("<leader>fb", "Buffers", function(builtin)
    builtin.buffers(get_theme_with_preview())
  end),
  keys_helper("<leader>fh", "Help", function(builtin)
    builtin.help_tags(get_theme())
  end),
  keys_helper("<leader>fd", "Diagnostics", function(builtin)
    builtin.diagnostics(get_theme_with_preview())
  end),
  keys_helper("<leader>fr", "LSP references", function(builtin)
    builtin.lsp_references(get_theme_with_preview())
  end),
}
