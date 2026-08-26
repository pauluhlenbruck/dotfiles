-- General
vim.opt.mouse = "a"
vim.opt.updatetime = 50
vim.opt.winborder = "rounded"
vim.g.have_nerd_font = true

-- Lines
vim.opt.number = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "89"

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Completion
vim.opt.completeopt = "menuone,noinsert"

-- Files
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.hlsearch = false

-- Don't have `o` add a comment
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})
vim.opt.formatoptions:remove("o")

-- Yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup(
    'highlight-yank', { clear = true }
  ),
  callback = function()
    vim.hl.on_yank()
  end,
})
