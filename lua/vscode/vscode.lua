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
    lazy = false,
    opts = {
      toggler = {
        line = 'gcc',
        block = 'gb'
      },
    }
  },
  "tpope/vim-rsi",
  {
    "kylechui/nvim-surround",
    -- event = "InsertEnter",
    lazy = false,
    opts = {}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    -- event = "BufReadPre",
    config = function()
      -- Using protected call
      local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      treesitter_config.setup {
        ensure_installed = { "yaml", "go", "tsx", "lua", "rust", "json", "graphql", "regex", "vim", },

        sync_install = false,
        auto_install = true,
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
          disable = {},
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = {}
        },
        endwise = {
          enable = true,
        },

        autotag = {
          enable = true
        },
        rainbow = {
          enable = false,
          extended_mode = true,
          max_file_lines = nil
        },
        -- markid = { enable = true }
      }
    end,
  }
}
require("lazy").setup(plugins, {
})

-- require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.autocmd')

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- save
map('n', "<leader>o", "<Cmd>call VSCodeNotify('workbench.action.files.save', 1)<CR>")
map('n', ",.", "<Cmd>call VSCodeNotify('workbench.action.files.save', 1)<CR>")

-- map('n', "<C-h>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex1', 1)<CR>")
-- map('n', "<C-t>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex2', 1)<CR>")
-- map('n', "<C-n>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex3', 1)<CR>")
-- map('n', "<C-s>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex4', 1)<CR>")

-- navigation
map('n', "go", "<Cmd>call VSCodeNotify('workbench.action.navigateBack', 1)<CR>")
map('n', "<leader>t", "<Cmd>call VSCodeNotify('workbench.action.navigateBack', 1)<CR>")
map('n', "gi", "<Cmd>call VSCodeNotify('workbench.action.navigateForward', 1)<CR>")

map('n', "<C-o>", "<Cmd>call VSCodeNotify('workbench.action.navigateBack', 1)<CR>")
map('n', "<C-i>", "<Cmd>call VSCodeNotify('workbench.action.navigateForward', 1)<CR>")

-- map('n', "S", "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>")

-- coma stuff
map('n', ',', ',')
map('n', ',d', "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")
map('n', ",t", "gt")

-- window
map('n', "<Tab>", "<Cmd>call VSCodeNotify('workbench.action.focusNextGroup')', 1)<CR>")
map('n', ",v", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')', 1)<CR>")
map('n', ",s", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')', 1)<CR>")


-- telescope
map('n', "<leader><leader>", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')', 1)<CR>")
map('n', "<leader>u", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')', 1)<CR>")

-- zen
map('n', "<leader>z", "<Cmd>call VSCodeNotify('workbench.action.toggleZenMode')', 1)<CR>")

-- debug
map('n', "<A-b>", "<Cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')', 1)<CR>")
map('n', "<leader>c", "<Cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')', 1)<CR>")

-- test
-- map('n', ",h", "<Cmd>call VSCodeNotify('extension.debugJest')', 1)<CR>")

-- explorer
map('n', "<leader>e", "<Cmd>call VSCodeNotify('vsnetrw.open')<CR>")

local lsp = [[
nnoremap S <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap ge <Cmd>call VSCodeNotify('editor.action.goToDeclaration')<CR>
nnoremap gE <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
]]

map('n', "gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')', 1)<CR>")

-- map('n', "<leader>e", "<Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup', 1)<CR>")
map('n', "<leader>r", "<Cmd>call VSCodeNotify('editor.action.rename', 1)<CR>")
map('n', "<leader>l", "<Cmd>call VSCodeNotify('editor.action.formatDocument', 1)<CR>")

map('n', "<leader>i",
  "<Cmd>call VSCodeNotify('editor.action.sourceAction', {'kind': 'source.addMissingImports', 'apply': 'first'})<CR>")
map('n', "<leader>d",
  "<Cmd>call VSCodeNotify('editor.action.sourceAction', {'kind': 'source.organizeImports', 'apply': 'first'})<CR>")

map('n', "<leader>/", "<Cmd>call VSCodeNotify('periscope.search', 1)<CR>")

-- map('n', "<leader>t", "<Cmd>call VSCodeNotify('workbench.actions.view.problems', 1)<CR>")
map('n', "<leader>t", "<Cmd>call VSCodeNotify('workbench.action.toggleAuxiliaryBar', 1)<CR>")

-- harpoon
map('n', "<leader>h", "<Cmd>call VSCodeNotify('vscode-harpoon.editEditors', 1)<CR>")
map('n', "M", "<Cmd>call VSCodeNotify('vscode-harpoon.addEditor', 1)<CR>")

map('n', "<C-h>", "<Cmd>call VSCodeNotify('vscode-harpoon.gotoEditor1', 1)<CR>")
map('n', "<C-t>", "<Cmd>call VSCodeNotify('vscode-harpoon.gotoEditor2', 1)<CR>")
map('n', "<C-n>", "<Cmd>call VSCodeNotify('vscode-harpoon.gotoEditor3', 1)<CR>")
map('n', "<C-s>", "<Cmd>call VSCodeNotify('vscode-harpoon.gotoEditor4', 1)<CR>")



vim.api.nvim_command(lsp)

map("n", "<C-d>", function()
  -- vim.cmd("call VSCodeExtensionCall('scroll', 'halfPage', 'down')")
  vim.cmd("call <SID>reveal('center', 0)")
end)
map("n", "<C-u>", function()
  -- vim.cmd("<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'up')")
  vim.cmd("call <SID>reveal('center', 0)")
end)
