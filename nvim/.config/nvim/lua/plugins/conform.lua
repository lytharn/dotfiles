return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>df",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[D]ocument [F]ormat",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    -- This will use the vim formatting keys gq
    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
