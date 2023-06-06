return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>u",       "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>/",       "<cmd>Telescope live_grep<CR>",  desc = "Find a string" },
    { "<leader>fh",      "<cmd>Telescope help_tags<CR>",  desc = "Help" },
    { "<leader>fg",      "<cmd>Telescope git_status<CR>", desc = "Find Git" },
  },
  config = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
      return
    end

    local actions = require('telescope.actions')
    telescope.setup {
      pickers = {
        colorscheme = {
          enable_preview = true
        },
        find_files = {
          hidden = true
        },
      },
      defaults = {
        path_display = { 'smart' },
        -- file_ignore_patterns = { '.git' },
        file_ignore_patterns = { "node_modules/", ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
          "%.pdf", "%.mkv", "%.mp4", "%.zip" },
        mappings = {
          i = {
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<esc>"] = actions.close
          }
        },
        layout_config = {
          horizontal = {
            -- prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          -- vertical = {
          --   mirror = false,
          -- },
          width = 0.87,
          height = 0.90,
          preview_cutoff = 120,
        },
        results_title = false,
        prompt_title = false,
        dynamic_preview_title = false,
        -- prompt_prefix = "   ",
        -- prompt_prefix = " 󱇪  ",
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        -- sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        winblend = 0,
        border = {},
        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- color_devicons = true,
        -- set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        -- Developer configurations: Not meant for general override
        -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

        center = {
          width = function(_, max_columns)
            local percentage = 0.5
            local max = 70
            return math.min(math.floor(percentage * max_columns), max)
          end,
          height = function(_, _, max_lines)
            local percentage = 0.5
            local min = 70
            return math.max(math.floor(percentage * max_lines), min)
          end

        },
        horizontal = {
          preview_cutoff = 100,
          preview_width = 0.6
        }
      }
    }
  end
}
