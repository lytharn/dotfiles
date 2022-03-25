return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      format = {
        defaultConfig = {
          quote_style = "double",
          call_arg_parantheses = "unambiguous_remove_string_only",
          trailing_table_separator = "smart",
        },
      },
    },
  },
}
