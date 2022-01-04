-- Autocommand that reloads neovim whenever you save the plugin.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin.lua source <afile> | PackerSync
  augroup end
]]

return require"packer".startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Color scheme
  use "rmehri01/onenord.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
end)
