local cache = {}

local function buf_harpoon(name)
  if name == "" then
    return nil
  end
  if cache[name] == nil then
    local index = require('harpoon.mark').get_index_of(vim.fn.bufname())
    if index == nil then
      index = ""
    end
    cache[name] = index
  end

  if cache[name] == "" then
    return nil
  end
  return cache[name]
end

-- local mark_color = "#FFA066"
local function set_mark_color(number, color, fg)
  if not fg then
    fg = "#000000"
  end
  vim.api.nvim_set_hl(0, 'Mark' .. number, { bg = color, fg = fg, bold = true })
  vim.api.nvim_set_hl(0, 'MarkEnd' .. number, { fg = color })
end

-- set_mark_color(1, "#FFA066")
-- set_mark_color(1, "#83A596", "#C8C093")
set_mark_color(1, "#54546D", "#C8C093")
set_mark_color(2, "#49443C", "#C8C093")
-- set_mark_color(2, "#e5c76b")
-- set_mark_color(4, "#E82424", "#C8C093")
set_mark_color(4, "#FB4934", "#5ee6f6")
-- set_mark_color(3, "#2A2A37", "#C8C093")
set_mark_color(3, "#e47d1c", "#49443C")
set_mark_color(5, "#76946A")
-- set_mark_color(4, "#ffffff")
-- set_mark_color(4, "#A3D4D5")

-- vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = "#181820", fg = "#C8C093", reverse = true })
-- vim.api.nvim_set_hl(0, "WinBar", { bg = "#FFA066", fg = "#000000" })

function tabline()
  if vim.bo.filetype == "netrw" then
    return "%F"
  end


  local is_modified = vim.bo.modified and "●" or ""
  -- local bufname = vim.api.nvim_eval_statusline('%t', {}).str
  -- local bufname = vim.api.nvim_eval_statusline('%f', {}).str
  local bufname = vim.api.nvim_eval_statusline('%t', {}).str
  if bufname == "NvimTree_1" then
    return ""
    -- return " %#WinBar#  %* NvimTree"
  end
  local extension = vim.fn.expand("%:e")
  local icon, color = require('nvim-web-devicons').get_icon(bufname, extension)
  local icon_str = icon and icon .. " " or ""
  -- section_separators = { left = '', right = '' },
  local current_mark = buf_harpoon(bufname)

  if current_mark == nil then
    return "  %#" .. color .. "# " .. icon_str .. "%*" ..
        bufname .. " " .. is_modified .. " %*"
      -- .. " %= %#Conceal#  󰅖%*"
      -- .. " %= %#Conceal#" .. searchCount() ..  "%*"
  else
    return "%#WinBar#" ..
        "%#Mark" .. current_mark .. "#  " .. current_mark .. "  %*" ..
        "%#MarkEnd" .. current_mark .. "#" .. "" .. "%*" ..
        "%#" .. color .. "# " .. icon_str .. "%*" ..
        bufname ..
        " " .. is_modified .. " %* "
      -- .. " %= %#Conceal#" .. searchCount() ..  "%*"
      -- .." %= %#Conceal#  󰅖%*"
  end
end

local function render_mark()
  local bufname = vim.api.nvim_eval_statusline('%t', {}).str
  local current_mark = buf_harpoon(bufname)
  return "%#Mark" .. current_mark .. "# " .. current_mark .. "  %*" ..
      "%#MarkEnd" .. current_mark .. "#" .. "" .. "%*"
end


local function open()
  -- vim.o.winbar = "%{%v:lua.tabline()%}"
  -- vim.o.statusline = "%{%v:lua.tabline()%}"
end

local function close()
  -- vim.o.winbar = ""
  -- vim.o.statusline = ""
end

local function toggle()
  if vim.o.winbar == "" then
    open()
  else
    close()
  end
end

-- open()
return {
  open = open,
  close = close,
  toggle = toggle,
  render_mark = render_mark,
  clear = function()
    cache = {}
  end
}

-- vim.o.winbar='%{%%}'
-- vim.o.winbar = '%!v:lua.tabline()'
