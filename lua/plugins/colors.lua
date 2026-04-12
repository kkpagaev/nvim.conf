return {
  "ellisonleao/gruvbox.nvim",
  commit = "6d409ee",
  lazy = false,
  priority = 1000,
  config = function()
    local palette = require("gruvbox.palette").get_base_colors("dark")

    require("gruvbox").setup {
      undercurl  = true,
      underline  = true,
      bold       = true,
      strikethrough     = true,
      invert_selection  = false,
      invert_signs      = false,
      invert_tabline    = false,
      invert_intend_guides = false,
      inverse    = true,
      contrast   = "hard",
      italic = {
        strings   = true,
        comments  = true,
        operators = false,
        folds     = true,
      },
      overrides = {
        NormalFloat  = { bg = "none" },
        FloatBorder  = { bg = "none" },
        FloatTitle   = { bg = "none" },
        StatusLine   = { fg = palette.bg0, bg = palette.fg1 },
        StatusLineNC = { fg = palette.bg0, bg = palette.fg3 },
        WinBar       = { bg = "" },
        WinBarNC     = { bg = "" },
        SignColumn        = { link = "Normal" },
        GruvboxGreenSign  = { bg = "" },
        GruvboxOrangeSign = { bg = "" },
        GruvboxPurpleSign = { bg = "" },
        GruvboxYellowSign = { bg = "" },
        GruvboxRedSign    = { bg = "" },
        GruvboxBlueSign   = { bg = "" },
        GruvboxAquaSign   = { bg = "" },
      },
    }

    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
}
