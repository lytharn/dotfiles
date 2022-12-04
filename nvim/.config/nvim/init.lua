require "user.option"
require("user.packer").setup(function()
  require "user.colorscheme"
  require "user.treesitter"
  require "user.comment"
  require "user.cmp"
  require "user.lsp"
  require "user.telescope"
  require "user.nvim-tree"
  require "user.navic"
  require "user.lualine"
  require "user.gitsigns"
  require "user.autopairs"
  require "user.harpoon"
  require("user.keymap").set_global_keymaps()
end)
