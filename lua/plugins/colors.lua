local theme = require('current-theme')

local themes = {
  gruvbox = {
    "ellisonleao/gruvbox.nvim",
    commit = "6d409ee",
    config = function()
      local palette = require("gruvbox.palette").get_base_colors("dark")

      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
          StatusLine = { fg = palette.bg0, bg = palette.fg1 },

          StatusLineNC = { fg = palette.bg0, bg = palette.fg3 },

          WinBar = { bg = "" },
          WinBarNC = { bg = "" },
          SignColumn = { link = "Normal" },
          GruvboxGreenSign = { bg = "" },
          GruvboxOrangeSign = { bg = "" },
          GruvboxPurpleSign = { bg = "" },
          GruvboxYellowSign = { bg = "" },
          GruvboxRedSign = { bg = "" },
          GruvboxBlueSign = { bg = "" },
          GruvboxAquaSign = { bg = "" },
        },
        dim_inactive = false,
        transparent_mode = false,
      })
    end
  }
}
local current_theme = themes[theme] or {"rebelot/kanagawa.nvim"}

local conf = function(callback)
    if callback ~= nil then
      callback()
    end
    vim.o.background = "dark"

    vim.cmd("colorscheme " .. theme)

    if theme ~= "MountainDew" then
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    end

    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
    -- vim.opt.laststatus = 0
    -- vim.o.cmdheight = 0
end

local con = current_theme["config"]

current_theme["config"] = function()

  if con == nil then
    vim.cmd("colorscheme " .. theme)
    return
  end
  --
  conf(con)
-- vim.cmd("colorscheme kikisen")
end

current_theme["lazy"] = false
current_theme["priority"] = 1000

return current_theme
