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
        filetypes = { "*" },
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
    lazy = true,
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
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      local luasnip = require 'luasnip'
      luasnip.setup {
        { history = true, updateevents = "TextChanged,TextChangedI" },
      }

      local loader = require("luasnip.loaders.from_snipmate")
      loader.lazy_load()
      --
      loader.lazy_load({ paths = { "./snippets" } })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
              require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      'hrsh7th/cmp-nvim-lsp',
      "saadparwaiz1/cmp_luasnip",
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
  {
    'mfussenegger/nvim-dap',
    keys = {
      "<C-g>",
      "<C-c>",
      "<C-r>",
      "<C-l>",
    },
    dependencies = {
      "rcarriga/cmp-dap",
      "leoluz/nvim-dap-go",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {}
      },
      { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
      -- "jlcrochet/vim-crystal",
    },
    lazy = true,
    config = function()
      require("plugins.config.dap")
    end
  },
  {
    "petertriho/nvim-scrollbar",
    opts = {}
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    keys = {
      {
        "<leader>t", "<CMD>TroubleToggle<CR>"
      }
    },
    opts = {},
  },
  {
    'nacro90/numb.nvim',
    lazy = false,
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = "InsertEnter",
    opts = {
    },
  },
  {
    "kylechui/nvim-surround",
    -- event = "InsertEnter",
    lazy = true,
    keys = { "cs", "ds" },
    opts = {}
  },
  -- 'mfussenegger/nvim-dap-python',
  -- "vimpostor/vim-tpipeline",
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

  -- {
  --   "axelvc/template-string.nvim",
  --   config = function()
  --     require('template-string').setup({
  --       filetypes = { 'vue', 'astro', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
  --       jsx_brackets = true,                                                                              -- must add brackets to jsx attributes
  --       remove_template_string = false,                                                                   -- remove backticks when there are no template string
  --       restore_quotes = {
  --         -- quotes used when "remove_template_string" option is enabled
  --         normal = [[']],
  --         jsx = [["]],
  --       },
  --     })
  --   end
  -- },
  -- {
  --   "vimwiki/vimwiki",
  --   event = "BufEnter *.md",
  -- },
  -- "andythigpen/nvim-coverage",
  --
  "tpope/vim-rsi",
  {
    "Exafunction/codeium.vim",
    lazy = false
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
     'tpope/vim-dadbod', lazy = true,
  dependencies = {
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } },
  },
  cmd = {
    'DB',
  }
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
--   {
--   'nvimdev/dashboard-nvim',
--   event = 'VimEnter',
--   config = function()
--     require('dashboard').setup {
--       -- config
--       hide = {
--   statusline = true   , -- hide statusline default is true
--   tabline       =true, -- hide the tabline
--   winbar        = true-- hide winbar
-- },
--     }
--   end,
--   dependencies = { {'nvim-tree/nvim-web-devicons'}}
-- }
-- lazy.nvim

}

require("lazy").setup(plugins, {
  defaults = {
    lazy = true
  }
})
