local M = {}

M.set_global_keymaps = function()
  --Remap space as leader key
  vim.keymap.set("", "<Space>", "<Nop>")
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Normal --
  -- Better window navigation
  vim.keymap.set("n", "<C-h>", "<C-w>h")
  vim.keymap.set("n", "<C-j>", "<C-w>j")
  vim.keymap.set("n", "<C-k>", "<C-w>k")
  vim.keymap.set("n", "<C-l>", "<C-w>l")

  -- Navigate tabs
  vim.keymap.set("n", "<A-h>", "gt")
  vim.keymap.set("n", "<A-l>", "gT")

  -- Telescope
  local telescope_ok, telescope = pcall(require, "telescope.builtin")
  if telescope_ok then
    vim.keymap.set("n", "<leader>ff", telescope.find_files)
    vim.keymap.set("n", "<leader>fg", telescope.live_grep)
    vim.keymap.set("n", "<leader>fb", telescope.buffers)
    vim.keymap.set("n", "<leader>fd", telescope.diagnostics)
    vim.keymap.set("n", "<leader>fo", telescope.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ft", telescope.lsp_workspace_symbols)
    vim.keymap.set("n", "<leader>fr", telescope.lsp_references)
  end

  -- Harpoon
  local harpoon_ok, _ = pcall(require, "harpoon")
  if harpoon_ok then
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    vim.keymap.set("n", "<leader>ja", mark.add_file)
    vim.keymap.set("n", "<leader>jq", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<leader>jw", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<leader>je", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<leader>jr", function() ui.nav_file(4) end)
    vim.keymap.set("n", "<leader>jl", ui.toggle_quick_menu)
    vim.keymap.set("n", "<C-n>", ui.nav_next)
    vim.keymap.set("n", "<C-p>", ui.nav_prev)
  end

  -- nvim-tree
  local tree_ok, tree = pcall(require, "nvim-tree.api")
  if tree_ok then
    -- toggle nvim-tree with current file selected
    vim.keymap.set("n", "<leader>e", function() tree.tree.toggle(true) end)
  end

  -- Insert --
  -- Press jk fast to enter
  vim.keymap.set("i", "jk", "<ESC>")

  -- Visual --
  -- Stay in indent mode
  vim.keymap.set("v", "<", "<gv")
  vim.keymap.set("v", ">", ">gv")

  -- Move text up and down
  vim.keymap.set("v", "<A-j>", ":m .+1<CR>==")
  vim.keymap.set("v", "<A-k>", ":m .-2<CR>==")

  -- Do not copy what is replaced with paste
  vim.keymap.set("v", "p", '"_dP')

  -- Visual Block --
  -- Move text up and down
  vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
  vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")
end

M.set_lsp_keymaps = function(bufnr)
  local opts = { buffer = bufnr }
  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-S-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end

M.set_gitlens_keymaps = function(bufnr)
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end
  local expr_opts = { expr = true, buffer = bufnr }

  -- Navigation
  vim.keymap.set("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(function() gitsigns.next_hunk() end)
    return "<Ignore>"
  end, expr_opts)

  vim.keymap.set("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(function() gitsigns.prev_hunk() end)
    return "<Ignore>"
  end, expr_opts)

  -- Actions
  local opts = { buffer = bufnr }
  vim.keymap.set({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, opts)
  vim.keymap.set({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, opts)
  vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, opts)
  vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)
  vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, opts)
  vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)
  vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, opts)
  vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, opts)
  vim.keymap.set("n", "<leader>htd", gitsigns.toggle_deleted, opts)

  -- Text object
  vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, opts)
end

return M
