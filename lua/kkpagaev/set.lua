local opt = vim.opt

opt.undodir  = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.swapfile = false
opt.shell    = "/bin/bash"

opt.relativenumber = true
opt.number         = true
opt.cursorline     = false
opt.inccommand     = "split"
opt.incsearch      = true
opt.ignorecase     = true
opt.smartcase      = true
opt.smartindent    = true

opt.tabstop     = 2
opt.softtabstop = 2
opt.shiftwidth  = 2
opt.expandtab   = true

opt.wrap        = false
opt.scrolloff   = 6
opt.signcolumn  = "yes"
opt.termguicolors = true
opt.pumheight   = 10

opt.shortmess:append("at")
opt.diffopt:append("vertical")
opt.display:append("lastline")
opt.fillchars = { eob = " " }

vim.o.timeout    = true
vim.o.timeoutlen = 1000
