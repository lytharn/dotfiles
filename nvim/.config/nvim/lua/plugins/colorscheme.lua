return {
  {
    "lunarvim/Onedarker.nvim",
    lazy = false,    -- This is the main colorscheme make sure it is loaded during startup
    priority = 1000, -- Load before all other start plugins
    config = function()
      vim.cmd("colorscheme onedarker")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
}
