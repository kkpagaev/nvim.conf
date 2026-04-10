
local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!open -a "Zen" ' . shellescape(expand('<cfile>') . '', 1)<CR>]], {})

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
map('i', "<M-d>", "<C-d>")
map('i', "<M-u>", "<C-u>")

local function buf_vtext()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

map('i', "<C-BS>", "<C-w>")
map('i', "<C-g>", "<C-o>")
map('i', "<C-d>", "<M-d>")
map('i', "<C-l>", "<Right>")


map('n', "t", "f")
map('n', "s", ",")
map('n', "f", "t")

map('n', "T", "F")
map('n', "F", "T")


vim.api.nvim_set_keymap('n', ',', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('n', ",d", ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })

vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map('n', "<leader>q", ":copen<cr>")

map('n', '<leader>i', ':TSToolsAddMissingImports<CR>')

map('n', '<leader>d', ':TSToolsRemoveUnused<CR>')

-- map('n', 'go', '<C-o>')
-- map('n', 'gi', '<C-i>')
-- map('n', 'gu', 'gi')
-- map('n', '<C-i>', '<C-i>')

map('n', "yf", 'jgg"+yG<c-o>k')

map('n', "cum", 'jgg"+yG<c-o>k')

map('n', 'U', '<c-r>')

map('n', 'S', 'K')

map('v', "<leader>y", '"+y')
map('n', "<leader>y", '"+y')

map('n', ",.", ':w<CR>')

-- vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

map('v', "J", "j")
map('v', "K", "k")

map('s', "h", "h")
map('s', "t", "t")
map('s', "j", "j")
map('s', "k", "k")
vim.keymap.set('n', '<esc>', function() vim.cmd('noh') end, { silent = true })

-- vim.keymap.set('n', '<leader>c', function()
--   local file_path = vim.api.nvim_buf_get_name(0)
--
--   local cmd = "cursor"
--
--   vim.uv.spawn(cmd, {
--     args = {file_path},
--     stdio = {nil, nil, nil},  -- no stdio handling
--   }, function(code, signal)
--     -- Optional callback when the process exits
--     print("Process exited with code " .. code .. " and signal " .. signal)
--   end)
-- end, { silent= true})

map('s', "H", "H")
map('s', "T", "T")
map('s', "J", "J")
map('s', "K", "K")

vim.keymap.set('n', 'go', '<C-o>')
vim.keymap.set('n', 'gi', '<C-i>')
-- vim.keymap.set('n', '<Tab>', '<C-W>w')
-- vim.keymap.set('n', '<S-Tab>', '<C-W>W')
-- vim.keymap.set('n', '<Tab>', '<C-W>w')
-- vim.keymap.set('n', '<S-Tab>', '<C-W>W')

-- ???
vim.keymap.set('n', '<C-f>', function()
  vim.fn.system('t')
end)

vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "(", "<cmd>keepjumps cprev<CR>zz")
vim.keymap.set("n", ")", "<cmd>keepjumps cnext<CR>zz")

vim.keymap.set("n", "gh", "<cmd>TSToolsGoToSourceDefinition<CR>")

vim.keymap.set({"n", "i"}, "<M-h>", "'h")
vim.keymap.set({"n", "i"}, "<M-t>", "'t")
vim.keymap.set({"n", "i"}, "<M-n>", "'n")
vim.keymap.set({"n", "i"}, "<M-s>", "'s")


vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
--
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", ",h", "'h")
-- vim.keymap.set("n", ",t", "'t")
-- vim.keymap.set("n", ",n", "'n")
-- vim.keymap.set("n", ",s", "'s")

vim.cmd([[nmap + %]])
vim.cmd([[vmap + %]])
vim.keymap.set("n", "+", "%")
vim.keymap.set("v", "+", "%")

vim.api.nvim_set_keymap('n', '<Leader>e', [[:sil lua CheckAndOpen()<CR>]], {silent = true})
-- vim.cmd([[map <silent> <Leader>e :Ex <bar> :sil! /<C-R>=expand("%:t")<CR><CR>]])

local latest_buffer = ""

function CheckAndOpen()
    if vim.bo.filetype == 'netrw' or vim.bo.filetype == 'oil' then
      -- opens latest_buffer in a buffer

      vim.cmd("e " .. latest_buffer)
    else
      local current_filename = vim.fn.expand("%:t")
      local current_buffer = vim.fn.expand("%:p")
      latest_buffer = current_buffer
      vim.cmd("Oil")
    end
end

vim.cmd([[au FileType netrw nmap <buffer> h -]])
vim.cmd([[au FileType netrw nmap <buffer> n <CR>]])
vim.cmd([[au FileType netrw nmap <buffer> a %]])


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-e>", "<C-I>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("v", "<leader>qf", function()
  local start = vim.fn.getpos("'<")[2]
  local finish = vim.fn.getpos("'>")[2]
  local lines = vim.fn.getline(start, finish)

  local items = {}
  for _, file in ipairs(lines) do
    if file ~= "" then
      table.insert(items, { filename = file })
    end
  end

  vim.fn.setqflist(items, "r")
  vim.cmd("copen")
end, { desc = "Send selected file list to quickfix" })

vim.keymap.set("v", "<leader>o", function()
  -- Get visual selection range
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  local items = {}
  for lnum = start_line, end_line do
    local text = vim.fn.getline(lnum)
    table.insert(items, {
      filename = vim.fn.expand("%"),
      lnum = lnum,
      text = text,
    })
  end

  -- Replace quickfix list and open it
  vim.fn.setqflist({}, "r", { title = "Visual Selection", items = items })
  vim.cmd("copen")
end, { desc = "Send visual selection to quickfix" })

