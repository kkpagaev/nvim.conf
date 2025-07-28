-- local theme = "vesper"
-- local theme = "MountainDew"
local theme = "gruvbox"
-- local theme = "reddish"
-- local theme = "zenbones"
-- local theme = "kanagawa"
-- local theme = "kanagawa-dragon"

-- local theme = "everblush"
-- local theme = "kanagawa-lotus"
-- local theme = "rose-pine"
-- local theme = "palenightfall"
-- local theme = "ofirkai"
-- local theme = "bamboo-multiplex"
-- local theme = "kanagawa-dragon"
-- local theme = "rose-pine"
-- local theme = "spaceduck"
-- local theme = "moonbow"

local themes = {
  automata = {
    "XadillaX/vim-automata-theme"
  },
  reddish = {
    "paulfrische/reddish.nvim"
  },
  zenbones = {
   "mcchrish/zenbones.nvim",
   dependencies = {
     "rktjmp/lush.nvim"
   },
   config = function()
     vim.o.background = "light"

   end
  },
  vesper = {
    'datsfilipe/vesper.nvim',
  },
  MountainDew = {
    "vim-scripts/MountainDew.vim",
  },
  kanagawa = {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        colors = {
          palette = {
            -- change all usages of these colors
            -- oniViolet = "#e46876",
            -- fujiWhite = "#FFFFFF",
          },
          theme = {
            all = {
              ui = {
                bg_p1 = 'none',
                bg_gutter = 'none'
              }
            }
          },
        },
        transparent = true,
        dimInactive = false,
        overrides = function(colors)
          local t = colors.theme
          return {
            TelescopeTitle = { fg = t.ui.special, bold = true },
            TelescopePromptNormal = { bg = t.ui.bg_m1 },
            TelescopePromptBorder = { fg = t.ui.bg_m1, bg = t.ui.bg_m1 },
            TelescopeResultsNormal = { fg = t.ui.fg_dim, bg = t.ui.bg_m1 },
            TelescopeResultsBorder = { fg = t.ui.bg_m1, bg = t.ui.bg_m1 },
            TelescopePreviewNormal = { bg = t.ui.bg_dim },
            TelescopePreviewBorder = { bg = t.ui.bg_dim, fg = t.ui.bg_dim },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            Pmenu = { fg = t.ui.shade0, bg = t.ui.bg_m1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = t.ui.bg_p2 },
            PmenuSbar = { bg = t.ui.bg_m1 },
            PmenuThumb = { bg = t.ui.bg_p2 },
            NormalDark = { fg = t.ui.fg_dim, bg = t.ui.bg_m3 },

            LazyNormal = { bg = t.ui.bg_m3, fg = t.ui.fg_dim },
            MasonNormal = { bg = t.ui.bg_m3, fg = t.ui.fg_dim },
          }
        end,
      })
    end
  },
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

            -- TelescopeTitle = { fg = palette.special, bold = true },
            -- TelescopePromptNormal = { bg = palette.bg0 },
            -- TelescopePromptBorder = { fg =  palette.bg0, bg = palette.bg0 },
            -- TelescopeResultsNormal = { fg = palette.fg0, bg = palette.bg1 },
            -- TelescopeResultsBorder = { fg = palette.bg0, bg = "none" },
            -- TelescopePreviewNormal = { bg = palette.bg1 },
            -- TelescopePreviewBorder = { bg = palette.bg1, fg = palette.bg1 },

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

-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
-- "arturgoms/moonbow.nvim",
--   "ofirgall/ofirkai.nvim",
-- "ellisonleao/gruvbox.nvim",
-- "Shatur/neovim-ayu",
-- "EdenEast/nightfox.nvim",
-- "NLKNguyen/papercolor-theme",
-- "pineapplegiant/spaceduck",
-- "rose-pine/neovim",
-- "xiyaowong/transparent.nvim",
-- "luisiacc/gruvbox-baby",
-- "Everblush/nvim"
local current_theme = themes[theme] or themes.kanagawa

local conf = function(callback)
    if callback ~= nil then
      callback()
    end
    vim.o.background = "dark"

    vim.cmd("colorscheme " .. theme)

    if theme ~= "MountainDew" then
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    end

    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "StatusLineN", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
    -- vim.opt.laststatus = 0
    -- vim.o.cmdheight = 0
end

local con = current_theme["config"]
current_theme["config"] = function()
  conf(con)
end

current_theme["lazy"] = false
current_theme["priority"] = 1000

return current_theme
