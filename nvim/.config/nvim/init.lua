_G.load_plugin_dependent_config = function() -- Called by user.packer
  require"user.colorscheme"
  require"user.treesitter"
  require"user.comment"
end

require"user.option"
require"user.keymap"
require"user.packer"
