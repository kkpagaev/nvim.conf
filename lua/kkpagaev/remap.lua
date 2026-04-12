
local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!open -a "Zen" ' . shellescape(expand('<cfile>') . '', 1)<CR>]], {})

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")

map('i', "<C-BS>", "<C-w>")
map('i', "<C-g>", "<C-o>")
map('i', "<C-d>", "<M-d>")
map('i', "<C-l>", "<Right>")


map('n', "t", "f")
map('n', "f", "t")

map('n', "T", "F")
map('n', "F", "T")


vim.api.nvim_set_keymap('n', ',', '<C-w>', { noremap = true })
map('n', ",.", ':w<CR>')
vim.api.nvim_set_keymap('n', ",d", ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })

vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map('n', "<leader>q", ":copen<cr>")

map('n', '<leader>i', ':TSToolsAddMissingImports<CR>')

map('n', '<leader>d', ':TSToolsRemoveUnused<CR>')

map('n', "yf", 'jgg"+yG<c-o>k')

map('n', 'U', '<c-r>')

map('v', "<leader>y", '"+y')
map('n', "<leader>y", '"+y')


map('v', "J", "j")
map('v', "K", "k")

vim.keymap.set('n', '<esc>', function() vim.cmd('noh') end, { silent = true })

vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "(", "<cmd>keepjumps cprev<CR>zz")
vim.keymap.set("n", ")", "<cmd>keepjumps cnext<CR>zz")

vim.keymap.set("n", "gh", "<cmd>TSToolsGoToSourceDefinition<CR>")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.cmd([[nmap + %]])
vim.cmd([[vmap + %]])
vim.keymap.set("n", "+", "%")
vim.keymap.set("v", "+", "%")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-i>", "<C-I>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
