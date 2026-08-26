return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  config = function()
    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
          analysis = { ignore = { "*" } },
        },
      },
    })

    vim.lsp.config("ruff", {
      init_options = {
        settings = {
          configurationPreference = "filesystemFirst",
          configuration = "~/.config/ruff/ruff.toml",
        },
      }
    }
    )

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp_attach_grp', {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Disable hover in favor of Pyright
        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end

        -- Auto-format on save.
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('lsp_attach_grp', { clear = false }),
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end
      end,
    })


    -- Diagnostics
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          if diagnostic.code then
            return string.format("%s [%s]", diagnostic.message, diagnostic.code)
          end
          return diagnostic.message
        end,
      },
      severity_sort = true,
    })

    -- Enable LSPs
    vim.lsp.enable({
      "lua_ls",
      "basedpyright",
      "ruff",
    })
  end,
}
