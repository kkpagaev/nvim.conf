local root_markers = {
  files = { "LICENSE", "MIT-LICENSE", "Makefile", "README.md", "package.json" },
  dirs  = { ".git", ".github" },
}

local home = os.getenv("HOME")

local function find_root(dir)
  if not vim.startswith(dir, home) then
    return dir
  end

  local current = dir
  while current ~= home do
    for _, name in ipairs(root_markers.files) do
      if vim.fn.filereadable(current .. "/" .. name) == 1 then
        return current
      end
    end
    for _, name in ipairs(root_markers.dirs) do
      if vim.fn.isdirectory(current .. "/" .. name) == 1 then
        return current
      end
    end
    current = vim.fn.fnamemodify(current, ":h")
  end
end

vim.keymap.set("n", ",c", function()
  local root = find_root(vim.fn.expand("%:p:h"))
  if root then
    vim.api.nvim_set_current_dir(root)
  end
end)
