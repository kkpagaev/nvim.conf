local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

au("TextYankPost", {
  group = ag("yank_highlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 50 }
  end,
})

vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "red", bg = "red" })

au({ "InsertEnter", "InsertLeave" }, {
  group = ag("trailing_whitespace", {}),
  pattern = "*",
  callback = function(ev)
    if ev.event == "InsertEnter" then
      vim.fn.matchadd("ExtraWhitespace", [[\s\+\%#\@<!$]], 10, -1)
    else
      vim.fn.clearmatches()
      vim.fn.matchadd("ExtraWhitespace", [[\s\+$]], 10, -1)
    end
  end,
})
