local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  -- client.server_capabilities.semanticTokensProvider = nil

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('ge', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gE', vim.lsp.buf.type_definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  -- nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  vim.keymap.set("n", "S", require("hover").hover, { desc = "hover.nvim" })
  vim.keymap.set("n", "gS", require("hover").hover_select, { desc = "hover.nvim (select)" })
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", ",t", vim.diagnostic.open_float)
  vim.keymap.set('n', '[*', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']*', vim.diagnostic.goto_next)

  -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

  local keymap = vim.keymap.set

  keymap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action)

  keymap("n", "<leader>r", vim.lsp.buf.rename)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- require "lsp_signature".on_attach({
  --   always_trigger = false,
  --   -- transparency = 0.5,
  -- }, bufnr)
end

local servers = {
  tsserver = {
  },
  lua_ls = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  automatic_enable = false
}

local sources = {
  -- nullls = {                     -- Name of source
  --   ignore = true,         -- Ignore notifications from this source
  -- },
}

sources["null-ls"] = {
  ignore = true
}

require('fidget').setup({
  sources = sources,
  window = {
    -- border = 'rounded',
    -- width = 60,
    -- height = 20,
    -- row = 0,
    -- col = 0,
    blend = 0,
  }
})

-- require 'lspconfig'.crystalline.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
-- }

-- require 'lspconfig'.solargraph.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--
--   root_dir = nvim_lsp.util.root_pattern(".rubocop.yml", ".git"),
--   settings = {
--     -- solargraph = {
--     --   diagnostics = true
--     -- }
--   },
-- }

require('lspconfig')['yamlls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemastore = {
        enable = true
      },
      trace = {
        server = "verbose"
      },
      schemas = {
        -- kubernetes = "/*.yaml",
        -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
        -- kubernetes = "*.k8s.yaml",
      }
    }
  }
}

-- require("lspconfig").emmet_ls.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "astro", "vue", "elixir", "eelixir", "heex" },
--   init_options = {
--     userLanguages = {
--       elixir = "html-eex",
--       eelixir = "html-eex",
--       heex = "html-eex",
--     },
--   },
-- })

require 'lspconfig'.tailwindcss.setup {
  filetypes = { "astro", "vue", "elixir", "eelixir", "heex" },
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
        },
      },
    },
  },
}

require("typescript-tools").setup {
  on_attach = on_attach,
  settings = {
    server_capabilities = { semanticTokensProvider = nil },
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    code_lens = "off",
    tsserver_format_options = {
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = false,
      quotePreference = "auto",
      importModuleSpecifierPreference = "relative"
    },
  },
}

-- require 'lspconfig'.sqls.setup {
--   settings = {
--     sqls = {
--       connections = {
--         {
--           driver = 'postgresql',
--           dataSourceName = 'host=127.0.0.1 port=1252 user=user password=user dbname=user',
--         },
--       },
--     },
--   },
-- }

require 'lspconfig'.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

local data_path = vim.fn.stdpath('data')
local location = data_path.."/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- require 'lspconfig'.volar.setup {
--   init_options = {
--           vue = {
--         -- disable hybrid mode
--         hybridMode = false,
--       },
--
--   },
--   filetypes = {
--     "javascript",
--     "typescript",
--     "vue",
--   },
--   on_attach = on_attach,
--   root_dir = nvim_lsp.util.root_pattern(".nuxt.config.ts", ".git"),
-- }

require 'lspconfig'.hls.setup {
  -- cmd = { "haskell-language-server-wrapper-2.10.0.0" },
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}
