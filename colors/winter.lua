vim.cmd("highlight clear")
vim.cmd("set termguicolors")
vim.g.colors_name = "mirror-winter"

local c = {
  bg = "#BDBDBD",
  bg_alt = "#C8C8C8",
  fg = "#2E2E2E",
  fg_dim = "#5E5E5E",
  white = "#F2F2F2",
  black = "#1E1E1E",
  lavender = "#B8B9D9",
  blue_gray = "#9FA6C3",
  accent = "#AEB3D6",
  subtle = "#8A8A8A",
}

local h = vim.api.nvim_set_hl

h(0, "Normal",        { fg = c.fg, bg = c.bg })
h(0, "NormalFloat",   { fg = c.fg, bg = c.bg_alt })
h(0, "LineNr",        { fg = c.subtle })
h(0, "CursorLineNr",  { fg = c.black })
h(0, "CursorLine",    { bg = c.bg_alt })
h(0, "Visual",        { bg = c.accent })

h(0, "Comment",       { fg = c.fg_dim, italic = true })
h(0, "Constant",      { fg = c.blue_gray })
h(0, "String",        { fg = c.lavender })
h(0, "Identifier",    { fg = c.black })
h(0, "Function",      { fg = c.black })
h(0, "Statement",     { fg = c.black })
h(0, "Keyword",       { fg = c.black })
h(0, "Type",          { fg = c.blue_gray })
h(0, "Operator",      { fg = c.fg })

h(0, "Pmenu",         { fg = c.fg, bg = c.bg_alt })
h(0, "PmenuSel",      { fg = c.black, bg = c.accent })

h(0, "StatusLine",    { fg = c.fg, bg = c.bg_alt })
h(0, "StatusLineNC",  { fg = c.subtle, bg = c.bg_alt })

h(0, "VertSplit",     { fg = c.subtle })
h(0, "WinSeparator",  { fg = c.subtle })

h(0, "Search",        { fg = c.black, bg = c.lavender })
h(0, "IncSearch",     { fg = c.black, bg = c.blue_gray })

h(0, "Error",         { fg = c.black, bg = c.lavender })
h(0, "Todo",          { fg = c.black, bg = c.accent })

