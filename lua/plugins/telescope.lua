return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim' },
  lazy = true,
  keys = {
    { "<leader><space>" },
    { "<Up>" },
    { "<leader>u" },
    { "<C-p>",          "<cmd>Telescope git_files<CR>",  desc = "Find a string", silent = true },
    { "<leader>/",      "<cmd>Telescope live_grep<CR>",  desc = "Find a string", silent = true },
    { "<leader>:",      "<cmd>Telescope commands<CR>",   desc = "Find a string", silent = true },
    { "<leader>fh",     "<cmd>Telescope help_tags<CR>",  desc = "Help",          silent = true },
    { "<leader>fg",     "<cmd>Telescope git_status<CR>", desc = "Find Git",      silent = true },
    { "<leader>fb",     "<cmd>Telescope buffers<CR>", desc = "Find Git",      silent = true },
    { "<leader>fy",     "<cmd>Telescope registers<CR>", desc = "Find Git",      silent = true },
    { ",r",             "<cmd>Telescope resume<CR>",     desc = "resume",        silent = true },
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
        -- path_display = { 'smart' },
        -- file_ignore_patterns = { '.git' },
        file_ignore_patterns = { "%pnpm-lock.yaml", "snippet/", "snippets/", "%package-lock.json", "target/", ".obsidian/", ".git/", ".cache", "%.out", "%.class",
          "%.ico", "%.pdf", "%.mkv", "%.ttf", "%.woff", "%.eot", "%.svg", '%.webp', '%.png', "%.mp4", "%.zip", "yarn.lock", ".yarn/", ".vscode/" },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-t>"] = actions.send_to_qflist + actions.open_qflist
          }
        },
        layout_config = {
          horizontal = {
            -- preview_width = 0.5,
            preview_width = 0,
            results_width = 0.8,
          },
          -- vertical = {
          --   mirror = false,
          -- },
          width = 0.90,
          height = 0.90,
          preview_cutoff = 20,
        },
        prompt_prefix = "   ",
      }
    }
    vim.keymap.set('v', '/', require("telescope.builtin").grep_string, {})
    vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, {
      silent = true
    })
    vim.keymap.set("n", "<leader>u", require("telescope.builtin").find_files, {
      silent = true
    })
    vim.keymap.set("n", "<Up>", require("telescope.builtin").find_files, {
      silent = true
    })
    -- vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, {
    --   silent = true
    -- })
  end
}
