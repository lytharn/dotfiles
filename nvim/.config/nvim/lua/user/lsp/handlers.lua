local M = {}

M.setup = function()
  -- Run :so $VIMRUNTIME/syntax/hitest.vim to show all highlighting groups
  local signs = {
    { hl = "DiagnosticSignError", icon = "" },
    { hl = "DiagnosticSignWarn", icon = "" },
    { hl = "DiagnosticSignHint", icon = "" },
    { hl = "DiagnosticSignInfo", icon = "" },
  }

  -- Change diagnostic symbols in the sign column
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.hl, { texthl = sign.hl, numhl = sign.hl, text = sign.icon })
  end

  local config = {
    virtual_text = true, -- Enable virtual text
    signs = true, -- Show signs

    -- Update diagnostics in Insert mode (if false, diagnostics are updated on InsertLeave)
    update_in_insert = true,
    underline = true, -- Use underline for diagnostics

    -- This affects the order in which signs and virtual text are displayed. When true, higher severities are displayed before lower severities (e.g. ERROR is displayed before WARN).
    severity_sort = true,
    float = { -- Used by vim.diagnostic.open_float()
      focusable = false,
      border = "rounded",
      source = true, -- Always show source
      header = "", -- No header
      prefix = "", -- No prefix
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function set_format_on_save(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local function attach_navic(client, bufnr)
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

M.on_attach = function(client, bufnr)
  require("user.keymap").set_lsp_keymaps(bufnr)
  set_format_on_save(client, bufnr)
  attach_navic(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
