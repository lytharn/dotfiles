local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then
  return
end

local servers = {
  "sumneko_lua",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local neodev_status_ok, neodev = pcall(require, "neodev")
    if not neodev_status_ok then
      return
    end
    neodev.setup({}) -- IMPORTANT: must be setup BEFORE lspconfig
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    lspconfig.sumneko_lua.setup(opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
