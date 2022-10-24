vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Ignore case in search patterns if no upper case
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Use relative line numbers
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.mouse = "a" -- Allow mouse usage
vim.opt.splitbelow = true -- Horizontal splits go below current window
vim.opt.splitright = true -- Vertical splits go to the right of current window
vim.opt.cursorline = true -- Highlight current line

-- Disable netrw to use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
