local gh = "https://github.com/"

vim.pack.add({
  -- shared dependencies
  { src = gh .. "nvim-lua/plenary.nvim" },
  { src = gh .. "nvim-tree/nvim-web-devicons" },

  -- colorscheme
  { src = gh .. "ellisonleao/gruvbox.nvim" },

  -- editing
  { src = gh .. "sheerun/vim-polyglot" },
  { src = gh .. "NvChad/nvim-colorizer.lua" },
  { src = gh .. "nacro90/numb.nvim" },
  { src = gh .. "kylechui/nvim-surround" },
  { src = gh .. "mbbill/undotree" },

  -- git
  { src = gh .. "lewis6991/gitsigns.nvim" },
  { src = gh .. "tpope/vim-fugitive" },
  { src = gh .. "tpope/vim-rhubarb" },

  -- lsp
  { src = gh .. "neovim/nvim-lspconfig" },
  { src = gh .. "pmizio/typescript-tools.nvim" },
  { src = gh .. "j-hui/fidget.nvim", version = "legacy" },

  -- completion
  { src = gh .. "hrsh7th/nvim-cmp" },
  { src = gh .. "hrsh7th/cmp-nvim-lsp" },
  { src = gh .. "hrsh7th/cmp-buffer" },

  -- formatting
  { src = gh .. "mhartington/formatter.nvim" },

  -- ui
  { src = gh .. "roobert/tailwindcss-colorizer-cmp.nvim" },

  -- navigation
  { src = gh .. "ThePrimeagen/harpoon", version = "harpoon2" },
  { src = gh .. "stevearc/oil.nvim" },
  { src = gh .. "folke/snacks.nvim" },
})

-- ── Colorscheme ────────────────────────────────────────────────────────────────

do
  local palette = require("gruvbox").palette

  require("gruvbox").setup {
    undercurl  = true,
    underline  = true,
    bold       = true,
    strikethrough     = true,
    invert_selection  = false,
    invert_signs      = false,
    invert_tabline    = false,
    invert_intend_guides = false,
    inverse    = true,
    contrast   = "hard",
    italic = {
      strings   = true,
      comments  = true,
      operators = false,
      folds     = true,
    },
    overrides = {
      NormalFloat  = { bg = "none" },
      FloatBorder  = { bg = "none" },
      FloatTitle   = { bg = "none" },
      StatusLine   = { fg = palette.bg0, bg = palette.dark0_hard },
      StatusLineNC = { fg = palette.bg0, bg = palette.fg3 },
      WinBar       = { bg = "" },
      WinBarNC     = { bg = "" },
      Visual            = { bg = "#3c3836" },
      Directory         = { fg = "#83a598" },
      LineNr            = { fg = "#504945" },
      CursorLineNr      = { fg = "#ebdbb2" },
      SignColumn        = { link = "Normal" },
      GruvboxGreenSign  = { bg = "" },
      GruvboxOrangeSign = { bg = "" },
      GruvboxPurpleSign = { bg = "" },
      GruvboxYellowSign = { bg = "" },
      GruvboxRedSign    = { bg = "" },
      GruvboxBlueSign   = { bg = "" },
      GruvboxAquaSign   = { bg = "" },
    },
  }

  vim.o.background = "dark"
  vim.cmd("colorscheme gruvbox")
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

-- ── UI ─────────────────────────────────────────────────────────────────────────

require("nvim-web-devicons").setup { color_icons = true, default = true }
require("colorizer").setup {
  filetypes = { "lua", "scss", "css", "typescriptreact", "javascriptreact", "vue", "astro", "conf", "kitty" },
}
require("tailwindcss-colorizer-cmp").setup { color_square_width = 2 }
require("numb").setup()

-- ── Editing ─────────────────────────────────────────────────────────────────────

require("nvim-surround").setup()

vim.keymap.set("n", ",u", "<CMD>UndotreeToggle<CR>", { silent = true })

-- ── Git ─────────────────────────────────────────────────────────────────────────

do
  local gitsigns = require("gitsigns")
  gitsigns.setup()
  vim.keymap.set("n", "[=", function()
    if vim.wo.diff then vim.cmd.normal({ "[=", bang = true })
    else gitsigns.nav_hunk("next") end
  end)
  vim.keymap.set("n", "]=", function()
    if vim.wo.diff then vim.cmd.normal({ "]=", bang = true })
    else gitsigns.nav_hunk("prev") end
  end)
end

do
  vim.keymap.set("v", "<leader>g", ":GBrowse<CR>", { silent = true })
  vim.keymap.set("n", "<leader>g", function()
    if vim.bo.ft ~= "fugitive" then
      vim.cmd.Git()
      vim.cmd("wincmd o")
    else
      vim.cmd("bd")
    end
  end, { silent = true })
  vim.keymap.set("n", "<leader>b", "<CMD>Git blame<CR>")
  vim.keymap.set("n", "gd", vim.cmd.Gdiffsplit)
  vim.keymap.set("n", "gw", vim.cmd.Gw)
  vim.keymap.set("n", "gl", "<CMD>Git log --oneline<CR>")
  vim.keymap.set("n", "gD", ":Gdiffsplit!<CR>", { silent = true })

  local group = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group, pattern = "*",
    callback = function()
      if vim.bo.ft ~= "git" then return end
      local opts = { buffer = vim.api.nvim_get_current_buf(), remap = false }
      vim.opt_local.includeexpr = "substitute(v:fname, '^[ab]/', '', '')"
      vim.keymap.set("n", "gf", "gF", opts)
    end,
  })

  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group, pattern = "*",
    callback = function()
      if vim.bo.ft ~= "fugitive" then return end
      local bufnr = vim.api.nvim_get_current_buf()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.winbar = "     "
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set("v", "/", function()
        local save_reg = vim.fn.getreg('"')
        vim.cmd('normal! "vy')
        local text = vim.fn.getreg('"')
        vim.fn.setreg('"', save_reg)
        text = vim.fn.escape(text, '"\\')
        vim.cmd('Git log --grep="' .. text .. '"')
      end, opts)
    end,
  })
end

-- ── Formatter ───────────────────────────────────────────────────────────────────

do
  local util = require("formatter.util")

  local function format_prettier()
    return {
      exe = vim.fn.expand("~/.config/yarn/global/node_modules/.bin/prettier-hbs"),
      args = { util.escape_path(util.get_current_buffer_file_path()) },
      stdin = true,
    }
  end

  require("formatter").setup {
    logging = true,
    filetype = {
      typescript          = { format_prettier },
      typescriptreact     = { format_prettier },
      javascriptreact     = { format_prettier },
      vue                 = { format_prettier },
      javascript          = { format_prettier },
      ["html.handlebars"] = { format_prettier },
      scss                = { format_prettier },
      astro               = { format_prettier },
    },
  }

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("formatting", {}),
    pattern = "*",
    callback = function()
      vim.cmd("FormatWrite")
    end,
  })
end

-- ── LSP ─────────────────────────────────────────────────────────────────────────

do
  require("fidget").setup { window = { blend = 0 } }

  vim.keymap.set("n", "S", function() vim.lsp.buf.hover({ border = "rounded" }) end)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
  vim.keymap.set("n", ",t", vim.diagnostic.open_float)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next)

  local on_attach = function(client, bufnr)
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end
    map("n",          "ge",          vim.lsp.buf.definition,     "Goto Definition")
    map("n",          "gE",          vim.lsp.buf.type_definition, "Goto Type Definition")
    map("n",          "gr",          vim.lsp.buf.references,      "Goto References")
    map({ "n", "v" }, "<leader>a",   vim.lsp.buf.code_action,    "Code Action")
    map("n",          "<leader>r",   vim.lsp.buf.rename,          "Rename")
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
      vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
  capabilities.textDocument.completion.completionItem.snippetSupport = false

  vim.lsp.config.tailwindcss = {
    on_attach    = on_attach,
    capabilities = capabilities,
    filetypes    = { "astro", "vue", "elixir", "eelixir", "heex", "javascriptreact", "typescriptreact", "html" },
  }

  vim.lsp.config.eslint = {
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr, command = "EslintFixAll",
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
        includeInlayParameterNameHints     = "all",
        includeCompletionsForModuleExports = false,
        quotePreference                    = "auto",
        importModuleSpecifierPreference    = "relative",
      },
    },
  }

  vim.lsp.config.coffeesense = {
    cmd          = { "coffeesense-language-server", "--stdio" },
    filetypes    = { "coffee" },
    root_markers = { "package.json", ".git" },
    on_attach    = on_attach,
    capabilities = capabilities,
  }

  vim.lsp.enable("tailwindcss")
  vim.lsp.enable("eslint")
  vim.lsp.enable("coffeesense")
  vim.lsp.enable("ruby_lsp")
  vim.lsp.enable("locales_lsp")
  vim.lsp.enable("capybar_lsp")
end

-- ── Completion ──────────────────────────────────────────────────────────────────

do
  local cmp = require("cmp")
  cmp.setup {
    preselect = cmp.PreselectMode.None,
    window = {
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
      ["<C-t>"]     = cmp.mapping.close(),
      ["<Down>"]    = cmp.mapping.select_next_item(),
      ["<Up>"]      = cmp.mapping.select_prev_item(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-f>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
        end
      end),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = {
      { name = "nvim_lsp", priority = 1000 },
      { name = "path" },
      { name = "buffer",   priority = 1 },
    },
  }
end

-- ── Navigation ──────────────────────────────────────────────────────────────────

do
  local harpoon = require("harpoon")
  harpoon:setup()

  vim.keymap.set({ "n", "v" }, "<leader>h", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end)

  local function nav_or_find(index)
    if harpoon:list():length() == 0 then
      Snacks.picker.files()
      return
    end
    vim.cmd("noh")
    harpoon:list():select(index)
  end

  vim.keymap.set("n", "<BS>",   function() nav_or_find(1) end)
  vim.keymap.set("n", "<C-t>",  function() vim.cmd("noh"); harpoon:list():select(2) end)
  vim.keymap.set("n", "<Down>", function() harpoon:list():select(3); vim.cmd("noh") end)
  vim.keymap.set("n", "<C-n>",  function() harpoon:list():select(3); vim.cmd("noh") end)
  vim.keymap.set("n", "<C-s>",  function() vim.cmd("noh"); harpoon:list():select(4) end)

  vim.keymap.set("n", "M",    function() harpoon:list():add(); print('Mark added') end)
  vim.keymap.set("n", "<CR>", function() harpoon:list():add(); print('Mark added') end)
end

do
  require("oil").setup {
    view_options = { show_hidden = true },
    columns = { "icon" },
    keymaps = {
      ["m"] = "actions.select",
      ["h"] = "actions.parent",
    },
  }

  local latest_buffer = ""
  vim.keymap.set("n", "<leader>e", function()
    if vim.bo.filetype == "oil" then
      vim.cmd("e " .. latest_buffer)
    else
      latest_buffer = vim.fn.expand("%:p")
      vim.cmd("Oil")
    end
  end, { silent = true })
end

do
  local exclude = {
    "solutions/", "files/emails", "snippet/", "snippets/", "target/",
    ".obsidian/", ".git/", ".yarn/", ".vscode/", "yarn.lock",
    "*.lock", "*.out", "*.class", "*.ico", "*.pdf", "*.mkv",
    "*.ttf", "*.woff", "*.eot", "*.svg", "*.webp", "*.png", "*.mp4", "*.zip",
  }

  require("snacks").setup {
    picker = {
      hidden  = true,
      exclude = exclude,
      layout  = {
        preset = "default",
        preview = false,
      },
      win = {
        input = {
          keys = {
            ["<C-t>"]     = { "qflist",      mode = { "i", "n" } },
            ["<c-space>"] = { "toggle_live", mode = { "i", "n" } },
          },
        },
      },
    },
  }

  local map = function(k, fn, desc)
    vim.keymap.set("n", k, fn, { silent = true, desc = desc })
  end

  map("<leader><space>", function() Snacks.picker.files() end,       "Find files")
  map("<Up>",            function() Snacks.picker.files() end,       "Find files")
  map("<leader>u",       function() Snacks.picker.files() end,       "Find files")
  map("<C-p>",           function() Snacks.picker.git_files() end,   "Find git files")
  map("<leader>/",       function() Snacks.picker.grep() end,        "Live grep")
  map("<leader>:",       function() Snacks.picker.commands() end,    "Commands")
  map("<leader>fh",      function() Snacks.picker.help() end,        "Help tags")
  map("<leader>fg",      function() Snacks.picker.git_status() end,  "Git status")
  map("<leader>t",       function() Snacks.picker.buffers() end,     "Buffers")
  map("<leader>fy",      function() Snacks.picker.registers() end,   "Registers")
  map(",r",              function() Snacks.picker.resume() end,      "Resume")

  vim.keymap.set("v", "/", function() Snacks.picker.grep_word() end)
end
