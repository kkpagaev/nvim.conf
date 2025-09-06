-- Nier Automata inspired Neovim theme (sepia / muted beige / dark)

local theme = {}

theme.colors = {
  bg       = "#d5d0ba", -- warm beige
  bg2       = "#afaa96", -- warm beige
  fg       = "#49463d", -- dark brown-gray
  accent   = "#6d5f53", -- muted brown
  faded    = "#8e8e90", -- softer text
  highlight= "#999999", -- lighter gray-beige
  red      = "#e06c75",
  yellow   = "#c4a75c",
  green    = "#4ea24c",
  blue     = "#6a7b8c",
  magenta  = "#8c6a7b",
  cyan     = "#5c8c87",
  orange   = "#d19a66",
}

local c = theme.colors

theme.setup = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.background = "light"
  vim.g.colors_name = "nier_automata"

  local set = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- UI
  set("Normal",       { fg=c.fg, bg=c.bg })
  set("LineNr",       { fg=c.accent, bg=c.bg })
  set("CursorLineNr", { fg=c.red, bold=true })
  set("VertSplit",    { fg=c.accent })
  set("StatusLine",   { fg=c.bg, bg=c.fg })
  set("StatusLineNC", { fg=c.fg, bg=c.highlight })
  set("Visual",       { bg=c.highlight })
  set("Search",       { fg=c.bg, bg=c.yellow })

  -- Syntax
  set("Comment",      { fg=c.faded, italic=true })
  set("Constant",     { fg=c.blue })
  set("String",       { fg=c.green })
  set("Identifier",   { fg=c.magenta })
  set("Function",     { fg=c.blue, bold=true })
  set("Statement",    { fg=c.red })
  set("Keyword",      { fg=c.red, bold=true })
  set("Type",         { fg=c.yellow })
  set("Special",      { fg=c.orange })
  set("Underlined",   { fg=c.blue, underline=true })
  set("NormalFloat",   { bg=c.bg2 })
end

theme.setup()

return theme
