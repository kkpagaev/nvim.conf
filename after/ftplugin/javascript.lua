vim.keymap.set("n", "s",
'^wwyeO/** @type {TaggedQuery<import("./queries/<C-R>=expand("%:t")<CR><BS><BS>types").<esc>pbiI<esc>l~EiQuery>} */<esc>^j^',
  { buffer = 0 }
)

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end
map('n', ',h', 'yiwoconsole.log(<esc>pa);<esc>V')
map('n', ',H', 'yiwOconsole.log(<esc>pa);<esc>')
map('v', ',', 'yoconsole.log({ <esc>pa });<esc>')

