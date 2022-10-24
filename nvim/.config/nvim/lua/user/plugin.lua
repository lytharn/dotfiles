-- Autocommand that reloads neovim whenever you save the plugin.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin.lua source <afile> | PackerSync
  augroup end
]]

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "numToStr/Comment.nvim" -- To simplify commenting
  use "nvim-lua/plenary.nvim" -- Lots of plugins depend on it

  -- Color scheme
  use "rmehri01/onenord.nvim"
  use "lunarvim/darkplus.nvim"
  use "lunarvim/Onedarker.nvim"
  use "folke/tokyonight.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Cmp
  use { "hrsh7th/nvim-cmp", tag = "v0.0.1" }
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use { "L3MON4D3/LuaSnip", tag = "v1.*" }
  use "saadparwaiz1/cmp_luasnip" -- Snippet completions

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "folke/neodev.nvim"

  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- For more stability than master
  }
end)
