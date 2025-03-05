return {
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
      -- winbar.clear()
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

        -- vim.keymap.set("v", "d", "dV", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("v", "j", ":m '>+1<CR>gv=gv", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("v", "j", ":m '>+1<CR>gv=gv", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("v", "J", "j", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("v", "K", "k", { buffer = true, noremap = true, silent = true })

        -- vim.keymap.set("v", "j", "<ESC>jV", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("v", "k", "<ESC>kV", { buffer = true, noremap = true, silent = true })
        --
        -- vim.keymap.set("n", "v", "V", { buffer = true, noremap = true, silent = true })
        -- vim.keymap.set("v", "v", "<esc>", { buffer = true, noremap = true, silent = true })
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

      -- winbar.clear()
      -- winbar.open()
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

          -- winbar.clear()
          -- winbar.open()
        end, { buffer = true, noremap = true, silent = true })
      end,
    })


    vim.keymap.set("n", "<leader>ch", function ()
      require("harpoon.mark").clear_all()
      -- winbar.clear()
      -- winbar.open()
    end)

    -- winbar.open()
  end
}
