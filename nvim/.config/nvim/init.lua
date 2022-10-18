_G.load_plugin_dependent_config = function() -- Called by user.packer
  require "user.colorscheme"
  require "user.treesitter"
  require "user.comment"
  require "user.cmp"
  require "user.lsp"
  require "user.telescope"
end

require "user.option"
require "user.keymap"
require "user.packer"
