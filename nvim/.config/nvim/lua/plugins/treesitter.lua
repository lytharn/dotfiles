return {
  "nvim-treesitter/nvim-treesitter",
  version = "9",
  build = ":TSUpdate",
  event = "VeryLazy",
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  -- Lazy-load on command
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    highlight = { enable = true },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "diff",
      "erlang",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "nix",
      "proto",
      "python",
      "regex",
      "rust",
      "toml",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<A-o>",
        node_incremental = "<A-o>",
        scope_incremental = false,
        node_decremental = "<A-i>",
      },
    },
  },
  -- Need to manually call setup because it resides in configs
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
