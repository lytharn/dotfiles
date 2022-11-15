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

local function set_lsp_keymaps(buffer)
  local opts = { silent = true, buffer = buffer }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-S-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function set_format_on_save(client, buffer)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.format({ bufnr = buffer })
      end,
    })
  end
end

M.on_attach = function(client, buffer)
  set_lsp_keymaps(buffer)
  set_format_on_save(client, buffer)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
