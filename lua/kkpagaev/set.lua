local o = vim.o

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.shell = "/bin/bash"

vim.g.tpipeline_autoembed = false

o.relativenumber = true
o.number = true
o.cursorline = false
o.inccommand = "split"

o.tabstop = 2
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.wrap = true
o.shortmess = o.shortmess .. "at"

vim.opt.diffopt = vim.opt.diffopt + "vertical"
vim.opt.display = vim.opt.display + 'lastline'
vim.opt.fillchars = {eob = " "}

vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes"
vim.opt.incsearch = true

o.ignorecase = true
o.smartcase = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.g.crystal_define_mappings = 0

vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.o.pumheight = 10
