-- LSP plugins
return {
  {
    -- `lazydev` configures LuaLS for editing your Neovim config by
    -- lazily updating your workspace libraries.
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', opts = {} },

    },
    config = function()
      -- This function gets run when an LSP attaches to a particular buffer.
      -- Every time a new buffer is opened that is associated with
      -- an lsp this function will be executed to configure the current buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lytharn-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "[G]o to [D]efinition")
          map("gi", require("telescope.builtin").lsp_implementations, "[G]o to [I]mplementation")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("<leader>gr", function() require("telescope.builtin").lsp_references { show_line = false } end,
            "[G]o to [R]eferences")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          map("<leader>fs", require("telescope.builtin").lsp_document_symbols, "[F]ind [S]ymbols")
          map("<leader>fS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[F]ind [S]ymbols in workspace")
          map("<leader>r", vim.lsp.buf.rename, "[R]ename")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
          map("K", vim.lsp.buf.hover, "Hover Documentation")

          -- Highlight references of the word under the cursor.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lytharn-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            -- Clean up if LSP detaches
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lytharn-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "lytharn-lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = {             -- Open with vim.diagnostic.open_float({opts})
          border = "rounded",
          source = "if_many", -- Only show the source if there are multiple sources of diagnostics
        },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        },
        virtual_text = {
          source = "if_many", -- Only show the source if there are multiple sources of diagnostics
          spacing = 2,
        },
      }

      -- By default, Neovim doesn't support everything that is in the LSP specification.
      -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Add any additional override configuration in the following tables. Available keys are:
      --  cmd (table): Override the default command used to start the server
      --  filetypes (table): Override the default list of associated filetypes for the server
      --  capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  settings (table): Override the default settings passed when initializing the server.
      local servers = {
        -- :help lspconfig-all for a list of all the pre-configured LSPs
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              format = {
                defaultConfig = {
                  quote_style = "double",
                  call_arg_parantheses = "unambiguous_remove_string_only",
                  trailing_table_separator = "smart",
                },
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
      }

      local servers_to_install = {}

      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --   :Mason
      -- You can press `g?` for help in this menu.
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(servers_to_install or {})
      vim.list_extend(ensure_installed, {})
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup {
        ensure_installed = {}, -- explicitly set to an empty table, populates installs via mason-tool-installer
        automatic_enable = false,
        handlers = {
          function(server_name)
            local server = servers_to_install[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      for server, opts in pairs(servers) do
        opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
        require("lspconfig")[server].setup(opts)
      end
    end,
  } }
