-- colors/kikisen.lua
local theme = {}

theme.colors = {
  bg       = "#B2B2B2",
  fg       = "#000000",
  accent   = "#FFFFFF",
  dim      = "#626262",
  mid1     = "#000000",
  mid2     = "#000000",
  mid3     = "#000000",
}

theme.setup = function()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "light"
  vim.g.colors_name = "kikisen"

  local set = function(group, opts)
    local parts = {}
    if opts.fg then table.insert(parts, "guifg=" .. opts.fg) end
    if opts.bg then table.insert(parts, "guibg=" .. opts.bg) end
    if opts.style then table.insert(parts, "gui=" .. opts.style) end
    vim.cmd("hi " .. group .. " " .. table.concat(parts, " "))
  end

  set("Normal", { fg = theme.colors.fg, bg = theme.colors.bg })
  set("Comment", { fg = theme.colors.dim, style = "italic" })
  set("Keyword", { fg = theme.colors.accent, style = "bold" })
  set("Identifier", { fg = theme.colors.fg })
  set("String", { fg = theme.colors.mid2 })
  set("Number", { fg = theme.colors.mid2 })
  set("Function", { fg = theme.colors.accent })
  set("Type", { fg = theme.colors.mid3, style = "bold" })
  set("Visual", { fg = theme.colors.bg, bg = theme.colors.fg })
  set("CursorLine", { bg = theme.colors.mid2 })
  set("StatusLine", { fg = theme.colors.accent, bg = theme.colors.dim })

  local c = theme.colors

  -- UI
  set("LineNr",       { fg=c.dim, bg=c.bg })
  set("CursorLineNr", { fg=c.dim, bold=true })
  set("VertSplit",    { fg=c.mid1 })
  set("StatusLineNC", { fg=c.dim, bg=c.highlight })
  set("Search",       { fg=c.dim, bg=c.yellow })

  -- -- Syntax
  set("Constant",     { fg=c.accent })
  set("Statement",    { fg=c.dim })
  set("Special",      { fg=c.accent })
  set("Underlined",   { fg=c.dim, underline=true })

  set("NormalFloat",   { bg=theme.colors.bg })
end

theme.setup()

