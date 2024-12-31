local FileName = {
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    filename = vim.fn.fnamemodify(filename, ":.")
    if filename == "" then
      return "[No Name]"
    end
    if not require("heirline.conditions").width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
}

local FileDirty = {
  condition = function()
    return vim.bo.modified
  end,
  provider = " [+]",
}

local File = { FileName, FileDirty }

local Git = {
  condition = function()
    return require("heirline.conditions").is_git_repo()
  end,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "orange" },

  { -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = "GitSignsAdd",
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = "GitSignsDelete",
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = "GitSignsChange",
  },
}

local Sep = { provider = " | " }

local StatusLine = {
  File,
  Sep,
  Git,
}

return {
  {
    "rebelot/heirline.nvim",
    dependencies = { "icons", "gitsigns" },
    opts = {
      statusline = StatusLine,
    },
  },
}
