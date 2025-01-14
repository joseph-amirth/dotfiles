local FileName = {
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    if filename == "" then
      return "[No Name]"
    else
      return vim.fs.basename(filename)
    end
  end,
}

local FileDirty = {
  condition = function()
    return vim.bo.modified
  end,
  provider = " [+]",
}

local File = { { provider = " " }, FileName, FileDirty }

local Mode = {
  static = {
    mode_names = {
      n = "NORMAL",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "VISUAL",
      vs = "Vs",
      V = "V-LINE",
      Vs = "Vs",
      ["\22"] = "V-BLOCK",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "INSERT",
      ic = "Ic",
      ix = "Ix",
      R = "REPLACE",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "COMMAND",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
    },
  },
  provider = function(self)
    return " " .. self.mode_names[self.mode] .. " "
  end,
  hl = function(self)
    return self.mode_hl
  end,
}

local FirstSep = {
  provider = "",
  hl = function(self)
    local conditions = require "heirline.conditions"
    if conditions.is_git_repo() or conditions.has_diagnostics() then
      return { fg = self.mode_color, bg = "#363a50" }
    else
      local hl = self.mode_hl
      return { fg = hl.bg, bg = hl.fg }
    end
  end,
}

local function make_hollow_arrow(condition)
  return { condition = condition, provider = "" }
end

local function make_solid_arrow(condition)
  return { condition = condition, provider = "", hl = { fg = "#363a50", bg = "#1e2031" } }
end

local Git = {
  condition = function()
    return require("heirline.conditions").is_git_repo()
  end,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = (self.status_dict.added or 0) > 0 or (self.status_dict.removed or 0) > 0 or (self.status_dict.changed or 0) > 0
  end,

  hl = function(self)
    return { fg = self.mode_color, bg = "#363a50" }
  end,

  {
    provider = function(self)
      return "  " .. self.status_dict.head .. " "
    end,
    hl = { bold = true },
  },
  make_hollow_arrow(function(self)
    return self.has_changes
  end),
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" +" .. count)
    end,
    hl = "GitSignsAdd",
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" -" .. count)
    end,
    hl = "GitSignsDelete",
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (" ~" .. count)
    end,
    hl = "GitSignsChange",
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = " ",
  },
  make_hollow_arrow(function()
    return require("heirline.conditions").has_diagnostics()
  end),
  make_solid_arrow(function()
    return not require("heirline.conditions").has_diagnostics()
  end),
}

local Diagnostics = {
  condition = function()
    return require("heirline.conditions").has_diagnostics()
  end,

  static = {
    error_icon = " ",
    warn_icon = " ",
    info_icon = " ",
    hint_icon = " ",
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  hl = function(self)
    return { fg = self.mode_color, bg = "#363a50" }
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      return self.errors > 0 and (" " .. self.error_icon .. self.errors)
    end,
    hl = "DiagnosticSignError",
  },
  {
    provider = function(self)
      return self.warnings > 0 and (" " .. self.warn_icon .. self.warnings)
    end,
    hl = "DiagnosticSignWarn",
  },
  {
    provider = function(self)
      return self.info > 0 and (" " .. self.info_icon .. self.info)
    end,
    hl = "DiagnosticSignInfo",
  },
  {
    provider = function(self)
      return self.hints > 0 and (" " .. self.hint_icon .. self.hints)
    end,
    hl = "DiagnosticSignHint",
  },
  {
    provider = " ",
  },
  make_solid_arrow(function()
    return true
  end),
}

local BasicRuler = {
  provider = "%P %l/%L:%c ",
}

local FancyRuler = {
  {
    provider = "",
    hl = { fg = "#363a50" },
  },
  {
    provider = " %P ",
    hl = function(self)
      return { fg = self.mode_color, bg = "#363a50" }
    end,
  },
  {
    provider = "",
    hl = function(self)
      return { fg = self.mode_color, bg = "#363a50" }
    end,
  },
  {
    provider = " %l/%L:%c ",
    hl = function(self)
      return self.mode_hl
    end,
  },
}

local FileTypeIcon = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  condition = function()
    return vim.bo.filetype ~= ""
  end,

  { { provider = " " }, FileTypeIcon },
  {
    provider = function()
      return vim.bo.filetype .. " "
    end,
  },
}

local FileMetadata = {
  {
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
      return enc .. " "
    end,
  },
  {
    provider = "",
  },
  {
    provider = function()
      return " " .. vim.bo.fileformat .. " "
    end,
  },
  FileType,
}

local StatusLine = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    self.mode_hl = require("heirline.utils").get_highlight(self.mode_colors[self.mode:sub(1, 1)])
    self.mode_color = self.mode_hl.bg
  end,
  static = {
    mode_colors = {
      n = "MiniStatuslineModeNormal",
      i = "MiniStatuslineModeInsert",
      v = "MiniStatuslineModeVisual",
      V = "MiniStatuslineModeVisual",
      ["\22"] = "MiniStatuslineModeVisual",
      c = "MiniStatuslineModeCommand",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      r = "MiniStatuslineModeReplace",
      R = "MiniStatuslineModeReplace",
      ["!"] = "red",
      t = "red",
    },
  },
  {
    -- When window is active.
    {
      condition = function()
        return require("heirline.conditions").is_active()
      end,
      { Mode, FirstSep, Git, Diagnostics, File, { provider = "%=" }, FileMetadata, FancyRuler },
    },
    -- When window is *not* active.
    {
      condition = function()
        return not require("heirline.conditions").is_active()
      end,
      { File, { provider = "%=" }, BasicRuler },
    },
  },
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
