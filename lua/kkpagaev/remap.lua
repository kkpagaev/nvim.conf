
local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], {})

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
-- map('v', "j", "h")
-- map('v', "h", "j")
--
-- map('v', "H", "j")
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

local function zod_to_json()
  -- if vim.fn.visualmode() ~= 'V' and vim.fn.visualmode() ~= 'v' then
  --     print("Not in Visual mode")
  --     return
  -- end

  local selected_text = buf_vtext()
  local res = vim.fn.system("ztj", selected_text)
  local jq = vim.fn.system("jq -r", res)
  vim.fn.system("clip", jq)
  -- exit to normal 

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)

  print(res)
end

-- vim.keymap.set('v', ',', zod_to_json, { noremap = true, silent = true })

map('i', "<C-BS>", "<C-w>")
map('i', "<C-g>", "<C-o>")
map('i', "<C-d>", "<M-d>")
map('i', "<C-l>", "<Right>")


map('n', "t", "f")
map('n', "s", ",")
map('n', "f", "t")

map('n', "T", "F")
map('n', "F", "T")


map("n", "YY", "va{Vy")

vim.api.nvim_set_keymap('n', ',', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('n', ",d", ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })

-- vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- quickfix
map('n', "<leader>q", ":copen<cr>")

map('n', '<leader>l', ':Format<CR>')
map('n', '<leader>i', ':TSToolsAddMissingImports<CR>')

map('n', ',h', 'yiwoconsole.log(<esc>pa);<esc>V')
map('n', ',H', 'yiwOconsole.log(<esc>pa);<esc>')
map('v', ',', 'yoconsole.log({ <esc>pa });<esc>')

map('n', '<leader>d', ':TSToolsRemoveUnused<CR>')

-- map('n', 'go', '<C-o>')
-- map('n', 'gi', '<C-i>')
-- map('n', 'gu', 'gi')
-- map('n', '<C-i>', '<C-i>')

map('n', "yf", 'jgg"+yG<c-o>k')

map('n', "cum", 'jgg"+yG<c-o>k')

map('n', 'U', '<c-r>')

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
vim.keymap.set('n', '<leader>c', function()
  local file_path = vim.api.nvim_buf_get_name(0)

  local cmd = "cursor"

  vim.uv.spawn(cmd, {
    args = {file_path},
    stdio = {nil, nil, nil},  -- no stdio handling
  }, function(code, signal)
    -- Optional callback when the process exits
    print("Process exited with code " .. code .. " and signal " .. signal)
  end)
end, { silent= true})

map('s', "H", "H")
map('s', "T", "T")
map('s', "J", "J")
map('s', "K", "K")

vim.keymap.set('n', '<Tab>', '<C-W>w')
vim.keymap.set('n', '<S-Tab>', '<C-W>W')

-- ???
vim.keymap.set('n', '<C-f>', function()
  vim.fn.system('t')
end)

vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "(", "<cmd>cprev<CR>zz")
vim.keymap.set("n", ")", "<cmd>cnext<CR>zz")

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


-- au FileType netrw nmap <buffer> <left> -

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-e>", "<C-I>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
