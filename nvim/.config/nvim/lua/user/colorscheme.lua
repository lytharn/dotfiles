-- local colorscheme = "onenord"
-- local colorscheme = "darkplus"
local colorscheme = "onedarker"
-- local colorscheme = "tokyonight"
local status_ok, colorscheme_module = pcall(require, colorscheme)
if not status_ok then
  vim.notify("Could not load colorscheme " .. colorscheme)
  return
end
colorscheme_module.setup()
