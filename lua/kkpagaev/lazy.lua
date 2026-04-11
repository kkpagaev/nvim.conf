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
        filetypes = { "lua", "scss", "css", "typescriptreact", "javascriptreact", "vue", "astro", "conf", "kitty" },
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
      -- { "<leader>b", "<CMD>Gitsigns blame_line<CR>" },
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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


        local util = require "formatter.util"

        -- :clown:
        local function format_eslint()
            return {
                exe = "eslint_d",
                args = {
                    "--stdin",
                    "--stdin-filename",
                    util.escape_path(util.get_current_buffer_file_path()),
                    "--fix-to-stdout",
                },
                stdin = true,
                try_node_modules = true,
            }
        end

        local function format_prettier()
            return {
                exe = "/Users/kkpagaev/.config/yarn/global/node_modules/.bin/prettier-hbs",
                args = { util.escape_path(util.get_current_buffer_file_path()) },
                stdin = true,
            }
        end

        local golang = require("formatter.filetypes.go")

        require('formatter').setup {
            logging = true,
            filetype = {

                typescript = { format_prettier },
                typescriptreact = { format_prettier },
                javascriptreact = { format_prettier },
                vue = { format_prettier },
                javascript = { format_prettier },
                ["html.handlebars"] = { format_prettier},
                -- html = { format_prettier },

                -- typescript = { format_eslint },
                -- javascript = { format_eslint },
                -- typescriptreact = { format_eslint },
                -- vue = { format_eslint },

                scss = { format_prettier },
                astro = { format_eslint },
                go = {
                    golang.gofmt,
                    golang.goimports,
                },
            }
        }

        local ag = vim.api.nvim_create_augroup
        local au = vim.api.nvim_create_autocmd

        au("BufWritePost", {
            group = ag("formatting", {}),
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "vue" then
                    return
                end
                vim.cmd("FormatWrite")
            end
        })
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "pmizio/typescript-tools.nvim",
      "lewis6991/hover.nvim",
      -- "ray-x/lsp_signature.nvim",
      {
        'j-hui/fidget.nvim',
        tag = "legacy"
      }
    },
    lazy = false,
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
        local cmp = require("cmp")

        cmp.setup {
          preselect = cmp.PreselectMode.None,
          window = {
            documentation = cmp.config.window.bordered(),
          },
          sorting = {
            --  comparators = {
            --     cmp.config.compare.recently_used
            -- },
          },
          mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ["<C-t>"] = cmp.mapping.close(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<C-f>'] = cmp.mapping(function()
              if cmp.visible() then
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
              end
            end),
            ['<C-Space>'] =
                cmp.mapping.complete({ }),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
              else
                fallback()
              end
            end, {
              'i',
              's',
            }),
          },
          sources = {
            { name = 'nvim_lsp', priority = 1000 },
            { name = 'path' },
            { name = 'buffer', priority = 1 },
          },
        }
    end
  },
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

      local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

      local autocmd = vim.api.nvim_create_autocmd
      autocmd("BufWinEnter", {
        group = ThePrimeagen_Fugitive,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "git" then
            return
          end
          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false }
          vim.opt_local.includeexpr = "substitute(v:fname, '^[ab]/', '', '')"

          vim.keymap.set("n", "gf", "gF", opts);
        end
      })
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

          vim.keymap.set("v", "/", function()
            -- yank visual selection into register
            local save_reg = vim.fn.getreg('"')
            vim.cmd('normal! "vy')
            local text = vim.fn.getreg('"')
            vim.fn.setreg('"', save_reg)

            -- escape quotes and inject into :Git log --grep
            text = vim.fn.escape(text, '"\\')

            vim.cmd('Git log --grep="' .. text .. '"')
          end, opts)
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
    {
  "ThePrimeagen/harpoon",
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-tree/nvim-web-devicons"
  },
  lazy = false,
  -- event = "InsertChange",
  keys = {
    "M",
    "<BS>",
    "<CR>",
    "<leader>h",
    "<C-h>",
    "<C-t>",
    "<C-n>",
    "<C-s>",
  },
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end

    harpoon.setup({
      tabline = false,
      menu = {
        -- borderchars = {},
        border = {}
      }
    })


    vim.keymap.set('v', '<leader>h', function()
      require("harpoon.ui").toggle_quick_menu()
      -- winbar.clear()
    end)
    vim.keymap.set('n', '<leader>h', function()
      require("harpoon.ui").toggle_quick_menu()
    end)

    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<BS>", function()
      if require("harpoon.mark").get_length() == 0 then
        require("telescope.builtin").find_files()
        return
      end
      vim.cmd('noh')
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<C-h>", function()
      if require("harpoon.mark").get_length() == 0 then
        require("telescope.builtin").find_files()

        return
      end
      vim.cmd('noh')
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      ui.nav_file(2)
      vim.cmd('noh')
    end)
    vim.keymap.set("n", "<Down>", function()
      ui.nav_file(3)
      vim.cmd('noh')
    end)
    vim.keymap.set("n", "<C-n>", function()
      ui.nav_file(3)
      vim.cmd('noh')
    end)
      vim.keymap.set("n", "<C-s>", function()
      vim.cmd('noh')
      ui.nav_file(4)
    end)

    local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      group = group,
      callback = function()
        vim.keymap.set("n", "s", function()
          local curline = vim.api.nvim_get_current_line()
          local working_directory = vim.fn.getcwd() .. "/"
          vim.cmd("vs")
          vim.cmd("e " .. working_directory .. curline)
        end, { buffer = true, noremap = true, silent = true })
      end,
    })

    vim.api.nvim_create_autocmd("BufDelete", {
      pattern = "harpoon",
      group = group,
      callback = function()
        -- winbar.clear()
      end,
    })

    vim.keymap.set("n", "M", function()
      local mark = require('harpoon.mark')
      local i = mark.get_current_index()

      mark.toggle_file(i)
    end)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local filetype = vim.bo.filetype
        if filetype == "qf" or filetype == "netrw" or filetype == "oil" then
          return
        end

        vim.keymap.set("n", "<CR>", function()
          local mark = require('harpoon.mark')
          local i = mark.get_current_index()

          mark.toggle_file(i)
        end, { buffer = true, noremap = true, silent = true })
      end,
    })
  end
},
{
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
        file_ignore_patterns = { "solutions/", "files/emails", "%pnpm-lock.yaml", "snippet/", "snippets/", "%package-lock.json", "target/", ".obsidian/", ".git/", "%.out", "%.class",
          "%.ico", "%.pdf", "%.mkv", "%.ttf", "%.woff", "%.eot", "%.svg", '%.webp', '%.png', "%.mp4", "%.zip", "yarn.lock", ".yarn/", ".vscode/" },
        mappings = {
              i = {
            ['<c-space>'] = 'to_fuzzy_refine',
            ['<c-g>'] = function(prompt_bufnr)
              local action_state = require('telescope.actions.state')
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              if not current_picker then
                print 'No active Telescope picker'
                return
              end

              local results = {}
              for entry in current_picker.manager:iter() do
                table.insert(results, entry)
              end

              local search_dirs = {}
              for _, subtable in ipairs(results) do
                if subtable.path then -- Check if the 'path' property exists
                  table.insert(search_dirs, subtable.path)
                end
              end

              require('telescope.builtin').live_grep { search_dirs = search_dirs }
            end,
            ["<esc>"] = actions.close,
            ["<C-t>"] = actions.send_to_qflist + actions.open_qflist
          },
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
  end
},
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "windwp/nvim-ts-autotag",
      },
      lazy = false,
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

          highlight = {
            enable = false,
            custom_captures = {
              ["attr.value"] = "TSKeyword"
            }
          },
        }
        require'treesitter-context'.setup{
          max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
        }
      end,
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
    }
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = true
  }
})
