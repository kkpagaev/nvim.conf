local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "echasnovski/mini.pick",
    lazy = false,
    keys = {
      { "<leader>u", "<CMD>Pick files<CR>" },
      { "<leader>fh", "<CMD>Pick help<CR>" },
    }
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    -- event = "VeryLazy",
    opts = {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      color_icons = true,
      default = true,
    },
  },
  {
    'numToStr/Comment.nvim',
    lazy = true,
    opts = {},
    keys = {
      { "gcc",  mode = "n" },
      { "gcip", mode = "n" },
      { "gc",   mode = "v" },
      { "gbc",  mode = "n" },
      { "gb",   mode = "v" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup {
        filetypes = { "lua", "css", "typescriptreact", "javascriptreact", "vue", "astro", "conf", "kitty" },
        user_default_options = {
          RGB = true,          -- #RGB hex codes
          RRGGBB = true,       -- #RRGGBB hex codes
          names = true,        -- "Name" codes like Blue or blue
          RRGGBBAA = false,    -- #RRGGBBAA hex codes
          AARRGGBB = false,    -- 0xAARRGGBB hex codes
          rgb_fn = false,      -- CSS rgb() and rgba() functions
          hsl_fn = false,      -- CSS hsl() and hsla() functions
          css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "foreground", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true,                                 -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
      { "<leader>b", "<CMD>Gitsigns blame_line<CR>" },
      { "[=" },
      { "]=" }
    },
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup()
      vim.keymap.set('n', '[=', function()
        if vim.wo.diff then
          vim.cmd.normal({'[=', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end)

      vim.keymap.set('n', ']=', function()
        if vim.wo.diff then
          vim.cmd.normal({']=', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end)
    end,
  },

  {
    "mhartington/formatter.nvim",
    event = "BufWritePre",
    lazy = false,
    config = function()
      require("plugins.config.formatter")
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "pmizio/typescript-tools.nvim",
      "lewis6991/hover.nvim",
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- "ray-x/lsp_signature.nvim",
      {
        'j-hui/fidget.nvim',
        tag = "legacy"
      }
    },
    lazy = false,
    event = "BufEnter",
    -- event = "InsertEnter",
    -- init = function()
    --   lazy_load "nvim-lspconfig"
    -- end,
    config = function()
      require("plugins.config.lsp")
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      require("plugins.config.cmp")
    end
  },
  {
    "lewis6991/hover.nvim",
    lazy = true,
    opts = {
      init = function()
        require("hover.providers.lsp")
      end,
      preview_opts = {
        border = nil
      },
      preview_window = false,
      title = true
    }
  },
  -- {
  --   'mfussenegger/nvim-dap',
  --   keys = {
  --     "<C-g>",
  --     "<C-c>",
  --     "<C-r>",
  --     "<C-l>",
  --   },
  --   dependencies = {
  --      "miroshQa/debugmaster.nvim",
  --     "rcarriga/cmp-dap",
  --     "leoluz/nvim-dap-go",
  --     "rcarriga/nvim-dap-ui",
  --     "mfussenegger/nvim-dap", "jbyuki/one-small-step-for-vimkind",
  --     "nvim-neotest/nvim-nio",
  --     {
  --       "theHamsta/nvim-dap-virtual-text",
  --       opts = {}
  --     },
  --     { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  --     -- "jlcrochet/vim-crystal",
  --   },
  --   lazy = true,
  --   config = function()
  --     require("plugins.config.dap")
  --   end
  -- },
   {
  "LunarVim/bigfile.nvim",
  -- enabled = false,
  event = "BufReadPre",
  opts = {
    features = { -- features to disable
      -- "filetype",
      "illuminate",
      "indent_blankline",
      "lsp",
      "matchparen",
      "syntax",
      "treesitter",
      -- "vimopts",
    },
  },
},
  {
    'nacro90/numb.nvim',
    lazy = false,
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    -- event = "InsertEnter",
    lazy = true,
    keys = { "cs", "ds" },
    opts = {}
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    lazy = false,
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.config.lint")
    end
  },
  {
    "mbbill/undotree",
    lazy = true,
    keys = { ',u' },
    config = function()
      vim.keymap.set("n", ",u", "<CMD>UndotreeToggle<CR>", {
        silent = true
      })
    end
  },
  {
    import = "plugins"
  },
  {
    "tpope/vim-fugitive",
    lazy = true,
    dependencies = {
      "tpope/vim-rhubarb"
    },
    cmd = {
      "Git",
      "GlLog",
      "Gwrite",
    },
    keys = {
      { "<leader>g" },
      { "gd" },
      { "gD" },
    },
    config = function()
      vim.keymap.set("n", "<leader>g", function()
        if vim.bo.ft ~= "fugitive" then
          vim.cmd.Git()
          vim.cmd("wincmd o")
        else
          vim.cmd("bd")
        end
      end, { silent = true })

      vim.keymap.set("n", "gd", vim.cmd.Gdiffsplit)
      vim.keymap.set("n", "gD", ":Gdiffsplit!<CR>", { silent = true })

      local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufWinEnter", {
        group = ThePrimeagen_Fugitive,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.winbar = "     "
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('push')
          end, opts)

          -- rebase always
          vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git({ 'pull', '--rebase' })
          end, opts)

          vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
        end,
      })
    end
  },
  {
    "danymat/neogen",
    lazy = true,
    keys = { {"<leader>na", "<cmd>Neogen func<cr>"}, {"<leader>nt", "<cmd>Neogen type<cr>"}},
    config = function()
        require('neogen').setup {}
    end,

  },
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    config = function ()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        columns = {
          "icon",
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["m"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["h"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      })
    end
  },
  -- {
  --   "dmtrKovalenko/fff.nvim",
  --   build = "cargo build --release",
  --   config = function () 
  --     require('fff').setup {
  --       -- UI dimensions and appearance
  --       width = 0.9,          -- Window width as fraction of screen
  --       height = 0.9,         -- Window height as fraction of screen
  --       preview_width = 0,  -- Preview pane width as fraction of picker
  --       prompt = ' ',       -- Input prompt symbol
  --       title = 'FFF Files',  -- Window title
  --       max_results = 60,     -- Maximum search results to display
  --       max_threads = 4,      -- Maximum threads for fuzzy search
  --
  --       keymaps = {
  --         close = '<C-c>',
  --         select = '<CR>',
  --         select_split = '<C-s>',
  --         select_vsplit = '<C-v>',
  --         select_tab = '<C-t>',
  --         move_up = { '<Up>', '<C-p>' },        -- Multiple bindings supported
  --         move_down = { '<Down>', '<C-n>' },    -- Multiple bindings supported
  --         preview_scroll_up = '<C-u>',
  --         preview_scroll_down = '<C-d>',
  --       },
  --
  --       hl = {
  --         border = 'FloatBorder',
  --         normal = 'Normal',
  --         cursor = 'CursorLine',
  --         matched = 'IncSearch',
  --         title = 'Title',
  --         prompt = 'Question',
  --         active_file = 'Visual',
  --         frecency = 'Number',
  --         debug = 'Comment',
  --       },
  --
  --       debug = {
  --         show_scores = true,  -- We hope for your collaboratio
  --       },
  --     }
  --   end,
  --   keys = {
  --     {
  --       "<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
  --       function()
  --         require("fff").toggle()
  --       end,
  --       desc = "Toggle FFF",
  --     },
  --   }
  -- },
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = true
  }
})
