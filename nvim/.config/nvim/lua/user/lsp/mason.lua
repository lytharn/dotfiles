local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then
  return
end

local servers_to_install = {
  "lua_ls",
}

local servers = {
  "rust_analyzer",
}

vim.list_extend(servers, servers_to_install)

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
  ensure_installed = servers_to_install,
  automatic_installation = false,
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

  if server == "lua_ls" then
    local neodev_status_ok, neodev = pcall(require, "neodev")
    if not neodev_status_ok then
      return
    end
    neodev.setup({}) -- IMPORTANT: must be setup BEFORE lspconfig
    local lua_opts = require "user.lsp.settings.lua_ls"
    opts = vim.tbl_deep_extend("force", lua_opts, opts)
    lspconfig.lua_ls.setup(opts)
    goto continue
  end

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust-tools"
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
