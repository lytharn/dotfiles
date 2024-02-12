-- Autocommand that reloads neovim whenever you save the plugin.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin.lua source <afile> | PackerSync
  augroup end
]]

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim"  -- Lots of plugins depend on it

  -- Color scheme
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
  use { "L3MON4D3/LuaSnip", tag = "v1.*" }
  use "saadparwaiz1/cmp_luasnip"

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "folke/neodev.nvim"
  use "simrat39/rust-tools.nvim"
  use "ray-x/lsp_signature.nvim"

  -- lualine
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  }
  use "arkav/lualine-lsp-progress"
  use "SmiteshP/nvim-navic"

  -- Other
  use "numToStr/Comment.nvim"
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    requires = { "nvim-lua/plenary.nvim" },
  }
  use {
    "nvim-tree/nvim-tree.lua", tag = "nightly",
    requires = { "nvim-tree/nvim-web-devicons" },
  }
  use { "lewis6991/gitsigns.nvim", tag = "v0.5" }
  use "windwp/nvim-autopairs"
  use {
    "ThePrimeagen/harpoon",
    requires = { "nvim-lua/plenary.nvim" },
  }
end)
