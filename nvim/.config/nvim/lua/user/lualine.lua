local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
  return
end

local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
  return
end

lualine.setup {
  options = {
    globalstatus = true,
  },
  sections = {
    lualine_c = {
      "lsp_progress",
    },
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { "filename",                                 path = 1 },
      { function() return navic.get_location() end, cond = function() return navic.is_available() end },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
