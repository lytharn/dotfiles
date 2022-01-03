-- Automatically install packer
local install_path = vim.fn.stdpath"data" .. "/site/pack/packer/start/packer.nvim"
local bootstrap_packer = vim.fn.empty(vim.fn.glob(install_path)) > 0
if bootstrap_packer then
  vim.fn.system{
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  -- Add packer to be able to use it
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify"Could not use packer!"
  return
end

-- Have packer use a popup window
packer.init{
  display = {
    open_fn = function()
      return require"packer.util".float { border = "rounded" }
    end,
  },
}

-- Add plugins
require"user.plugin"

if bootstrap_packer then
  packer.sync() -- Update, install and compile plugins
  vim.cmd [[autocmd User PackerComplete ++once lua load_plugin_dependent_config()]]
else
  load_plugin_dependent_config()
end
