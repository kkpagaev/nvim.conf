vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map = function(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Leader
map("n", "<leader>", "")

-- Insert mode
map("i", "<C-BS>", "<C-w>")
map("i", "<C-g>",  "<C-o>")
map("i", "<C-d>",  "<M-d>")
map("i", "<C-l>",  "<Right>")
map("i", "<C-c>",  "<ESC>")

-- Motion remaps (swap f/t behaviour)
map("n", "t", "f")
map("n", "f", "t")
map("n", "T", "F")
map("n", "F", "T")

-- Window / file ops
map("n", ",",  "<C-w>")
map("n", ",.", ":w<CR>")
map("n", ",d", ":q<CR>")

-- Indentation
map("n", ">", ">>")
map("n", "<", "<<")

-- Undo / redo
map("n", "U", "<C-r>")

-- Search
map("n", "<esc>", function() vim.cmd("noh") end)
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Substitute word under cursor
vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("x", "<leader>p", '"_dP')

-- Quickfix
map("n", "<leader>q", ":copen<CR>")
map("n", "(", "<cmd>keepjumps cprev<CR>zz")
map("n", ")", "<cmd>keepjumps cnext<CR>zz")

-- Jump list (centered)
map("n", "<C-i>", "<C-I>zz")
map("n", "<C-o>", "<C-o>zz")

-- Join without moving cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Match bracket
map("n", "+", "%")
map("v", "+", "%")

-- Yank file contents
map("n", "yf", 'jgg"+yG<C-o>k')

-- TypeScript tools
map("n", "<leader>i", ":TSToolsAddMissingImports<CR>")
map("n", "<leader>d", ":TSToolsRemoveUnused<CR>")
map("n", "gh",        "<cmd>TSToolsGoToSourceDefinition<CR>")

-- Filetype keymaps
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ft_keymaps", { clear = true }),
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact", "coffee" },
  callback = function()
    local m = function(mode, k, v)
      vim.keymap.set(mode, k, v, { silent = true, buffer = true })
    end
    m("n", ",h", "odebugger<esc>:w<cr>")
    m("n", ",H", "yiwOconsole.log(<esc>pa);<esc>")
    m("v", ",",  "yoconsole.log({ <esc>pa });<esc>")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ft_keymaps_cucumber", { clear = true }),
  pattern = "cucumber",
  callback = function()
    vim.keymap.set("n", ",h", "oAnd   I stop at breakpoint<esc>:w<cr>", { silent = true, buffer = true })
  end,
})

-- Open URL under cursor in Zen browser
vim.keymap.set("n", "gx", function()
  vim.fn.jobstart({ "open", "-a", "Zen", vim.fn.expand("<cfile>") }, { detach = true })
end)
