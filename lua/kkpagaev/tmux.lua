vim.keymap.set("n", "<leader>o", function()
  local file = vim.fn.expand("%:p")
  if not (file:match("_spec%.rb$") or file:match("%.feature$")) then
    vim.notify("Not a spec or feature file", vim.log.levels.WARN)
    return
  end
  local line = vim.fn.line(".")
  vim.fn.system("tmux send-keys -t 3 'r " .. file .. ":" .. line .. "' Enter")
  vim.fn.system("tmux select-window -t 3")
end, { silent = true, desc = "Run spec/feature file in tmux window 3" })

vim.keymap.set("n", "<leader>O", function()
  local file = vim.fn.expand("%:p")
  if not file:match("%.feature$") then
    vim.notify("Not a spec or feature file", vim.log.levels.WARN)
    return
  end
  local line = vim.fn.line(".")
  vim.fn.system("tmux send-keys -t 3 'HEADLESS=false r " .. file .. ":" .. line .. "' Enter")
  vim.fn.system("tmux select-window -t 3")
end, { silent = true, desc = "Run spec/feature file in tmux window 3" })
