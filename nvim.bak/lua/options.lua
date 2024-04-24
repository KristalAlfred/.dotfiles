-- This enables 24-bit color, which is useful for most external colorschemes.
-- I think it looks better without for now though.
vim.opt.termguicolors = false

vim.opt.nu = true

vim.opt.keywordprg = ':help' -- Fix 'K' issue..

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.wo.relativenumber = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.timeoutlen = 200

vim.api.nvim_command('filetype plugin on')
