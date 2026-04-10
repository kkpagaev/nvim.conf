return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "windwp/nvim-ts-autotag",
    -- "RRethy/nvim-treesitter-endwise",
    -- "nvim-treesitter/playground",
    -- 'nvim-treesitter/nvim-treesitter-context',
  },
  lazy = false,
  -- event = "BufReadPre",
  config = function()
    -- Using protected call
    local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    treesitter_config.setup {
      ensure_installed = { "yaml", "go", "tsx", "lua", "json", "graphql", "regex", "vim", "markdown", "markdown_inline", "dockerfile", "prisma", "vue",

      "vimdoc", "luadoc", "vim", "lua", "markdown"
    },
      -- ensure_installed = {'c', 'cpp', 'bash', 'lua', 'vim', 'python', 'c_sharp', 'git_rebase', 'git_config', 'gitignore'}

      sync_install = false,
      -- auto_install = true,
      -- playground = {
      --   enable = true,
      -- },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "v",
          node_decremental = "V",
        }
      },
      highlight = {
        enable = false,
            custom_captures = {
      ["attr.value"] = "TSKeyword"
    }
        -- additional_vim_regex_highlighting = { "markdown" },
      },
      -- indent = {
      --   enable = false,
      --   disable = {
      --   }
      -- },
      -- endwise = {
      --   enable = true,
      -- },
      --
      -- autotag = {
      --   enable = true
      -- },
      -- markid = { enable = true }
    }
    require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
  end,
  -- init = function()
  --   lazy_load("nvim-treesitter")
  -- end,
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
}
