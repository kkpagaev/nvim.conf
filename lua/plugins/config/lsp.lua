  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

-- vim.keymap.set("n", "S", require("hover").hover, { desc = "hover.nvim" })
vim.keymap.set('n', 'S', function()
  vim.lsp.buf.hover({
    border = "rounded"
  })
end)
vim.keymap.set("n", "gS", require("hover").hover_select, { desc = "hover.nvim (select)" })
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
vim.keymap.set("n", ",t", vim.diagnostic.open_float)
vim.keymap.set('n', ']d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
nmap('ge', vim.lsp.buf.definition, '[G]oto [D]efinition')
nmap('gE', vim.lsp.buf.type_definition, '[G]oto [D]efinition')
nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  -- client.server_capabilities.semanticTokensProvider = nil

  -- nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')


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

capabilities.textDocument.completion.completionItem.snippetSupport = true

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


vim.lsp.config.tailwindcss = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 
    "astro",
    "vue",
    "elixir",
    "eelixir",
    "heex",
    "javascriptreact",
    "typescriptreact",
    "html"
  },
  init_options = {},
  settings = {
    -- "tailwindCSS.files.exclude" = {
    --   "**/.git/**",
    --   "**/node_modules/**",
    --   "**/.hg/**",
    --   "tmp/**",
    --   "public/**",
    --   "coverage/**"
    -- },
    --
    --
    -- "tailwindCSS.classAttributes" = {
    --   "class",
    --   "className",
    --   "classNames",
    --   "variants",
    --   "defaultVariants"
    -- },
    -- "tailwindCSS.experimental.classRegex" = {
    --   ["cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"],
    --   ["cn\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"],
    --   ["cx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)"]
    -- }
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

vim.lsp.config.eslint = ({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- vim.lsp.config.ruby_lsp.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
-- }
-- require('lspconfig.configs').locales_lsp = {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   default_config = {
--     cmd = { 'node', '/Users/kkpagaev/gitlab/locales-lsp/dist/server.js', '--stdio' },
--     filetypes = { 'ruby', 'eruby', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'yaml', 'coffee' },
--     root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
--   },
-- }
-- require('lspconfig').locales_lsp.setup({})
--
-- require('lspconfig.configs').capybar_lsp = {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   default_config = {
--     cmd = { 'node', '/Users/kkpagaev/gitlab/capybar-lsp/dist/server.js', '--stdio' },
--     filetypes = { 'cucumber', 'ruby' },
--     root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
--   },
-- }
-- require('lspconfig').capybar_lsp.setup({})

-- require('lspconfig.configs').ruby_lsp = {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   default_config = {
--     -- cmd = { 'node', '/Users/kkpagaev/gitlab/capybar-lsp/dist/server.js', '--stdio' },
--     -- filetypes = { 'cucumber', 'ruby' },
--     -- root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
--   },
-- }

-- require('lspconfig').ruby_lsp.setup({})

vim.lsp.enable('html')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('ruby_lsp')
