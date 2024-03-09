-- local theme = "everblush"
-- local theme = "kanagawa-lotus"
-- local theme = "gruvbox-baby"
-- local theme = "gruvbox"
-- local theme = "rose-pine"
-- local theme = "palenightfall"
-- local theme = "ofirkai"
local theme = "kanagawa"
-- local theme = "bamboo-multiplex"
-- local theme = "kanagawa-dragon"
-- local theme = "rose-pine"
-- local theme = "spaceduck"
-- local theme = "moonbow"
return {
    "ellisonleao/gruvbox.nvim",
  commit = "6d409ee",
  dependencies = {
    "rose-pine/neovim",
    "JoosepAlviste/palenightfall.nvim",
    "rebelot/kanagawa.nvim",
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
  },
  lazy = false,
  priority = 1000,
  -- install = { colorscheme = { "moonbow" } },
  -- oniViolet
  config = function()

    -- require('bamboo').setup {
    --  transparent = true, -- Show/hide background
    --   dim_inactive = false, -- Dim inactive windows/buffers
    --   -- optional configuration here
    --   highlights = {
    --     -- make comments blend nicely with background, similar to other color schemes
    --     ['@comment'] = { fg = '$grey' },
    --     ["WinBar"] = { fg = '$fg' },
    --       -- optional configuration here
    --   }
    -- }
    -- require('bamboo').load()

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
        local theme = colors.theme
        return {
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_m1 },
          TelescopePromptBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        }
      end,
    })

    -- require("gruvbox").setup({
    --   undercurl = true,
    --   underline = true,
    --   bold = true,
    --   italic = {
    --     strings = true,
    --     comments = true,
    --     operators = false,
    --     folds = true,
    --   },
    --   strikethrough = true,
    --   invert_selection = false,
    --   invert_signs = false,
    --   invert_tabline = false,
    --   invert_intend_guides = false,
    --   inverse = true, -- invert background for search, diffs, statuslines and errors
    --   contrast = "hard",  -- can be "hard", "soft" or empty string
    --   palette_overrides = {},
    --   overrides = {
    --     WinBar = { bg = "" },
    --     WinBarNC = { bg = "" },
    --     SignColumn = { link = "Normal" },
    --     GruvboxGreenSign = { bg = "" },
    --     GruvboxOrangeSign = { bg = "" },
    --     GruvboxPurpleSign = { bg = "" },
    --     GruvboxYellowSign = { bg = "" },
    --     GruvboxRedSign = { bg = "" },
    --     GruvboxBlueSign = { bg = "" },
    --     GruvboxAquaSign = { bg = "" },
    --   },
    --   dim_inactive = false,
    --   transparent_mode = false,
    -- })

    -- vim.cmd("colorscheme gruvbox")

    -- require("transparent").setup({
    --   groups = { -- table: default groups
    --     'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    --     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    --     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    --     'SignColumn', 'CursorLineNr', 'EndOfBuffer',
    --   },
    --   extra_groups = {}, -- table: additional groups that should be cleared
    --   exclude_groups = {}, -- table: groups you don't want to clear
    -- })

    -- vim.g.gruvbox_baby_telescope_theme = 1

-- Enable transparent mode
-- vim.g.gruvbox_baby_transparent_mode = 1

    -- vim.cmd("colorscheme everblush")
    -- vim.cmd("colorscheme kanagawa-lotus")
    -- vim.cmd("colorscheme gruvbox-baby")
    vim.cmd("colorscheme " .. theme)
    -- vim.cmd("colorscheme kanagawa")
    -- vim.cmd("colorscheme spaceduck")
    -- vim.cmd("colorscheme moonbow")
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "StatusLineN", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

    -- vim.cmd("TransparentEnable")
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
    -- vim.opt.laststatus = 0
    -- vim.o.cmdheight = 0
  end
  -- commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",
  --
  -- name = "kanagawa",
}
