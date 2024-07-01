return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = "▎" },
      change       = { text = "▎" },
      delete       = { text = "󰐊" },
      topdelete    = { text = "󰐊" },
      changedelete = { text = "▎" },
      untracked    = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Move to next hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Move to previous hunk" })

      -- Actions
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
      map("v", "<leader>hs", function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        { desc = "Stage hunk" })
      map("v", "<leader>hr", function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
        { desc = "" })
      map("n", "<leader>ds", gitsigns.stage_buffer, { desc = "[D]ocument [S]tage" })
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "[H]unk [U]ndo stage" })
      map("n", "<leader>dr", gitsigns.reset_buffer, { desc = "[D]ocument [R]eset" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
      map("n", "<leader>lb", function() gitsigns.blame_line { full = true } end, { desc = "[L]ine [B]lame" })
      map("n", "<leader>ltb", gitsigns.toggle_current_line_blame, { desc = "[L]ine [T]oggle [B]lame" })
      map("n", "<leader>dd", gitsigns.diffthis, { desc = "[D]ocument [D]iff" })
      map("n", "<leader>fD", function() gitsigns.diffthis("~") end, { desc = "[D]ocument [D]iff parent" })
      map("n", "<leader>dtd", gitsigns.toggle_deleted, { desc = "[D]ocument [T]oggle [D]eleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
  },
}
