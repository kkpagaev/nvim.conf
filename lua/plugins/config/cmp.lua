local cmp = require("cmp")
-- local lspkind = require('lspkind')

vim.cmd([[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]])

cmp.setup {
  -- completion = {
  --     autocomplete = false
  -- },
  preselect = cmp.PreselectMode.None,
  -- completion = {
  --   completeopt = "menu,menuone",
  -- },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  sorting = {
    --  comparators = {
    --     cmp.config.compare.recently_used
    -- },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ["<C-t>"] = cmp.mapping.close(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-f>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
      end
    end),
    ['<C-Space>'] =
        cmp.mapping.complete({
          -- reason = cmp.ContextReason.Auto,
        }),
    -- ['<CR>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = false,
    -- },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  sources = {
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'path' },
    { name = 'buffer', priority = 1 },
  },
}

-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({
--   filetypes = {
--     ruby = {}
--   }
-- }))

