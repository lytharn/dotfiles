local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  preview_config = {
    border = "rounded",
  },
  on_attach = function(bufnr)
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
  end,
}
