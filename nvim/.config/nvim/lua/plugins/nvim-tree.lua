local function on_tree_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open file"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Collapse node"))
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    -- Enable nice icons
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- Use nvim-tree instead of netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    require("nvim-tree").setup({
      on_attach = on_tree_attach,
      view = {
        width = {
          min = 30,
          max = -1,
          padding = 1,
        },
      },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>",
      { desc = "Toggle nvim tree and select current file." })
  end,
}
