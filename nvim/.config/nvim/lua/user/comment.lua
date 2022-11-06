local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup({
  toggler = {
    line = "<C-_>", -- Ctrl + /
  },
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = false,
    ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
    extended = false,
  },
})
