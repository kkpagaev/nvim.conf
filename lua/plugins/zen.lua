return {
    "folke/zen-mode.nvim",
    lazy = true,
    keys = {
      "<F5>",
      "<leader>z"
    },
    config = function()
      require("zen-mode").setup {
        plugins = {
          tmux = { enabled = false },
        },
        on_open = function(_)

          -- vim.o.cmdheight = 0
          -- vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
          -- vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
        end,
        on_close = function()
          -- vim.o.cmdheight = 1
          -- if vim.b.quitting == 1 then
          --   vim.b.quitting = 0
          --   vim.cmd 'q'
          -- end
        end,

        window = {
            height = 1,
          -- width = 90,
          -- width = 90,
          options = {
            -- number = false,
            -- relativenumber = false
        }
        },
      }
      vim.keymap.set("n", "<leader>z", function()
        require("zen-mode").toggle()
      end)
      vim.keymap.set("n", "<F5>", function()
        require("zen-mode").toggle()
      end)
    end
}
