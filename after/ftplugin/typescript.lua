
local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end
map('n', ',h', 'yiwoconsole.log(<esc>pa);<esc>V')
map('n', ',H', 'yiwOconsole.log(<esc>pa);<esc>')
map('v', ',', 'yoconsole.log({ <esc>pa });<esc>')

