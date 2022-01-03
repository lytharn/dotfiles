local colorscheme = "onenord"
local status_ok, colorscheme_module = pcall(require, colorscheme)
if not status_ok then
  vim.notify("Could not load colorscheme " .. colorscheme)
  return
end
colorscheme_module.setup()
