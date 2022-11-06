_G.load_plugin_dependent_config = function() -- Called by user.packer
  require "user.colorscheme"
  require "user.treesitter"
  require "user.comment"
  require "user.cmp"
  require "user.lsp"
  require "user.telescope"
  require "user.nvim-tree"
  require "user.lualine"
  require "user.gitsigns"
  require "user.autopairs"
  require "user.keymap"
end

require "user.option"
require "user.packer"
