local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- for coffeescript only
  {
    "sheerun/vim-polyglot",
    lazy = false,  -- don't load immediately
    config = function()
      -- vim.g.polyglot_disabled = {} -- or list languages to disable
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup {
        filetypes = { "lua", "scss", "css", "typescriptreact", "javascriptreact", "vue", "astro", "conf", "kitty" },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup()
      vim.keymap.set("n", "[=", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[=", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)
      vim.keymap.set("n", "]=", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]=", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)
    end,
  },
  {
    "mhartington/formatter.nvim",
    lazy = false,
    event = "BufWritePre",
    config = function()
      local util = require("formatter.util")

      local function format_prettier()
        return {
          exe = "/Users/kkpagaev/.config/yarn/global/node_modules/.bin/prettier-hbs",
          args = { util.escape_path(util.get_current_buffer_file_path()) },
          stdin = true,
        }
      end

      require("formatter").setup {
        logging = true,
        filetype = {
          typescript       = { format_prettier },
          typescriptreact  = { format_prettier },
          javascriptreact  = { format_prettier },
          vue              = { format_prettier },
          javascript       = { format_prettier },
          ["html.handlebars"] = { format_prettier },
          scss             = { format_prettier },
          astro            = { format_prettier },
        },
      }

      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("formatting", {}),
        pattern = "*",
        callback = function()
          if vim.bo.filetype ~= "vue" then
            vim.cmd("FormatWrite")
          end
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "pmizio/typescript-tools.nvim",
      { "j-hui/fidget.nvim", tag = "legacy" },
    },
    config = function()
      require("plugins.config.lsp")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        preselect = cmp.PreselectMode.None,
        window = {
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-t>"]     = cmp.mapping.close(),
          ["<Down>"]    = cmp.mapping.select_next_item(),
          ["<Up>"]      = cmp.mapping.select_prev_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-f>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp", priority = 1000 },
          { name = "path" },
          { name = "buffer",   priority = 1 },
        },
      }
    end,
  },
  {
    "nacro90/numb.nvim",
    lazy = false,
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    lazy = true,
    keys = { "cs", "ds" },
    opts = {},
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    lazy = false,
    opts = { color_square_width = 2 },
  },
  {
    "mbbill/undotree",
    lazy = true,
    keys = { ",u" },
    config = function()
      vim.keymap.set("n", ",u", "<CMD>UndotreeToggle<CR>", { silent = true })
    end,
  },
  { import = "plugins" },
  {
    "tpope/vim-fugitive",
    lazy = true,
    dependencies = { "tpope/vim-rhubarb" },
    cmd = { "Git", "GlLog", "Gwrite" },
    keys = {
      { "<leader>g" },
      { "<leader>b" },
      { "gd" },
      { "gD" },
      { "gw" },
      { "gl" },
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
      vim.keymap.set("n", "<leader>b", "<CMD>Git blame<CR>")
      vim.keymap.set("n", "gd", vim.cmd.Gdiffsplit)
      vim.keymap.set("n", "gw", vim.cmd.Gw)
      vim.keymap.set("n", "gl", "<CMD>Git log --oneline<CR>")
      vim.keymap.set("n", "gD", ":Gdiffsplit!<CR>", { silent = true })

      local group = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})
      local autocmd = vim.api.nvim_create_autocmd

      autocmd("BufWinEnter", {
        group = group,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "git" then return end
          local opts = { buffer = vim.api.nvim_get_current_buf(), remap = false }
          vim.opt_local.includeexpr = "substitute(v:fname, '^[ab]/', '', '')"
          vim.keymap.set("n", "gf", "gF", opts)
        end,
      })

      autocmd("BufWinEnter", {
        group = group,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then return end
          local bufnr = vim.api.nvim_get_current_buf()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.winbar = "     "
          local opts = { buffer = bufnr, remap = false }
          vim.keymap.set("v", "/", function()
            local save_reg = vim.fn.getreg('"')
            vim.cmd('normal! "vy')
            local text = vim.fn.getreg('"')
            vim.fn.setreg('"', save_reg)
            text = vim.fn.escape(text, '"\\')
            vim.cmd('Git log --grep="' .. text .. '"')
          end, opts)
        end,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    config = function()
      require("oil").setup {
        view_options = { show_hidden = true },
        columns = { "icon" },
        keymaps = {
          ["g?"]   = "actions.show_help",
          ["m"]    = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["h"]    = "actions.parent",
          ["_"]    = "actions.open_cwd",
          ["`"]    = "actions.cd",
          ["~"]    = "actions.tcd",
          ["gs"]   = "actions.change_sort",
          ["gx"]   = "actions.open_external",
          ["g."]   = "actions.toggle_hidden",
          ["g\\"]  = "actions.toggle_trash",
        },
      }
    end,
  },
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup {
        tabline = false,
        menu = { border = {} },
      }

      local ui = require("harpoon.ui")
      local mark = require("harpoon.mark")

      vim.keymap.set({ "n", "v" }, "<leader>h", ui.toggle_quick_menu)

      vim.keymap.set("n", "<BS>", function()
        if mark.get_length() == 0 then
          require("telescope.builtin").find_files()
          return
        end
        vim.cmd("noh")
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<C-h>", function()
        if mark.get_length() == 0 then
          require("telescope.builtin").find_files()
          return
        end
        vim.cmd("noh")
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<C-t>", function() vim.cmd("noh"); ui.nav_file(2) end)
      vim.keymap.set("n", "<Down>", function() ui.nav_file(3); vim.cmd("noh") end)
      vim.keymap.set("n", "<C-n>", function() ui.nav_file(3); vim.cmd("noh") end)
      vim.keymap.set("n", "<C-s>", function() vim.cmd("noh"); ui.nav_file(4) end)

      vim.keymap.set("n", "M", function()
        mark.toggle_file(mark.get_current_index())
      end)

      local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "harpoon",
        group = group,
        callback = function()
          vim.keymap.set("n", "s", function()
            local curline = vim.api.nvim_get_current_line()
            vim.cmd("vs")
            vim.cmd("e " .. vim.fn.getcwd() .. "/" .. curline)
          end, { buffer = true, noremap = true, silent = true })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local ft = vim.bo.filetype
          if ft == "qf" or ft == "netrw" or ft == "oil" then return end
          vim.keymap.set("n", "<CR>", function()
            mark.toggle_file(mark.get_current_index())
          end, { buffer = true, noremap = true, silent = true })
        end,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader><space>" },
      { "<Up>" },
      { "<leader>u" },
      { "<C-p>",      "<cmd>Telescope git_files<CR>",  desc = "Find git files",  silent = true },
      { "<leader>/",  "<cmd>Telescope live_grep<CR>",  desc = "Live grep",       silent = true },
      { "<leader>:",  "<cmd>Telescope commands<CR>",   desc = "Commands",        silent = true },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Help tags",       silent = true },
      { "<leader>fg", "<cmd>Telescope git_status<CR>", desc = "Git status",      silent = true },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Buffers",         silent = true },
      { "<leader>fy", "<cmd>Telescope registers<CR>",  desc = "Registers",       silent = true },
      { ",r",         "<cmd>Telescope resume<CR>",     desc = "Resume",          silent = true },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup {
        pickers = {
          colorscheme = { enable_preview = true },
          find_files  = { hidden = true },
        },
        defaults = {
          file_ignore_patterns = {
            "solutions/", "files/emails", "%pnpm-lock.yaml", "snippet/", "snippets/",
            "%package-lock.json", "target/", ".obsidian/", ".git/", "%.out", "%.class",
            "%.ico", "%.pdf", "%.mkv", "%.ttf", "%.woff", "%.eot", "%.svg", "%.webp",
            "%.png", "%.mp4", "%.zip", "yarn.lock", ".yarn/", ".vscode/",
          },
          mappings = {
            i = {
              ["<c-space>"] = "to_fuzzy_refine",
              ["<c-g>"] = function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                if not current_picker then return end
                local search_dirs = {}
                for entry in current_picker.manager:iter() do
                  if entry.path then
                    table.insert(search_dirs, entry.path)
                  end
                end
                require("telescope.builtin").live_grep { search_dirs = search_dirs }
              end,
              ["<esc>"] = actions.close,
              ["<C-t>"] = actions.send_to_qflist + actions.open_qflist,
            },
          },
          layout_config = {
            horizontal = {
              preview_width = 0,
              results_width = 0.8,
            },
            width = 0.90,
            height = 0.90,
            preview_cutoff = 20,
          },
          prompt_prefix = "   ",
        },
      }

      local builtin = require("telescope.builtin")
      vim.keymap.set("v", "/", builtin.grep_string)
      vim.keymap.set("n", "<leader><space>", builtin.find_files, { silent = true })
      vim.keymap.set("n", "<leader>u", builtin.find_files, { silent = true })
      vim.keymap.set("n", "<Up>", builtin.find_files, { silent = true })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "yaml", "go", "tsx", "lua", "json", "graphql", "regex", "vim",
          "markdown", "markdown_inline", "dockerfile", "prisma", "vue",
          "vimdoc", "luadoc",
        },
        highlight = {
          enable = false,
        },
      }
      require("treesitter-context").setup {
        max_lines = 2,
      }
    end,
  },
}

require("lazy").setup(plugins, {
  defaults = { lazy = true },
})
