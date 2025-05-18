-- Clear highlight search by escaping in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left of current" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right of current" })

-- Move line up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move line down" })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move line up" })

-- Do not copy what is replaced with paste
vim.keymap.set("v", "p", '"_dP')

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
