vim.keymap.set("n", "S", function()
  vim.lsp.buf.hover({ border = "rounded" })
end)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
vim.keymap.set("n", ",t", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next)

local on_attach = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("n", "ge",         vim.lsp.buf.definition,      "Goto Definition")
  map("n", "gE",         vim.lsp.buf.type_definition,  "Goto Type Definition")
  map("n", "gr",         vim.lsp.buf.references,       "Goto References")
  map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>r",  vim.lsp.buf.rename,           "Rename")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities.textDocument.completion.completionItem.snippetSupport = true


vim.lsp.config.tailwindcss = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "astro", "vue", "elixir", "eelixir", "heex",
    "javascriptreact", "typescriptreact", "html",
  },
}

require("typescript-tools").setup {
  on_attach = on_attach,
  settings = {
    server_capabilities        = { semanticTokensProvider = nil },
    separate_diagnostic_server = true,
    publish_diagnostic_on      = "insert_leave",
    tsserver_plugins           = {},
    tsserver_max_memory        = "auto",
    code_lens                  = "off",
    tsserver_file_preferences  = {
      includeInlayParameterNameHints    = "all",
      includeCompletionsForModuleExports = false,
      quotePreference                   = "auto",
      importModuleSpecifierPreference   = "relative",
    },
  },
}

vim.lsp.config.eslint = {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

vim.lsp.config.locales_lsp = {
  cmd          = { "node", "/Users/kkpagaev/gitlab/locales-lsp/dist/server.js", "--stdio" },
  filetypes    = { "ruby", "eruby", "javascript", "javascriptreact", "typescript", "typescriptreact", "yaml", "coffee" },
  root_markers = { "Gemfile", ".git" },
  capabilities = capabilities,
  on_attach    = on_attach,
}

vim.lsp.config.capybar_lsp = {
  cmd          = { "node", "/Users/kkpagaev/gitlab/capybar-lsp/dist/server.js", "--stdio" },
  filetypes    = { "cucumber", "ruby" },
  root_markers = { "Gemfile", ".git" },
  capabilities = capabilities,
  on_attach    = on_attach,
}

require('fidget').setup({window = { blend = 0 }})

vim.lsp.enable("html")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ruby_lsp")
vim.lsp.enable("locales_lsp")
vim.lsp.enable("capybar_lsp")
