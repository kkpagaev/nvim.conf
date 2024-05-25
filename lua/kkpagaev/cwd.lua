local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local ui = require("harpoon.ui")

local root_files = { "LICENSE", "package.json", "Makefile", "README.md" }
local root_dirs = { ".git", ".github" }
-- local og_root_dir = vim.fn.expand('%:p:h')

local function parse_file()
  local parsed_table = {}
  local file = io.open("/home/kkpagaev/my_table.txt", "r")
  if file then
      -- Read each line from the file
      for line in file:lines() do
          parsed_table = vim.list_extend(parsed_table, { line })
      end

      -- Close the file
      file:close()
  end

  return parsed_table
end

-- parse_file()

-- -- Check if file is opened successfully
local function write_table_to_file(my_table)
  local file = io.open("/home/kkpagaev/my_table.txt", "w")
  if file then
      --iterate through the table
      for _, v in ipairs(my_table) do
          file:write(v .. "\n")
      end

      -- Close the file
      file:close()
      print("Table saved to file successfully.")
  else
      print("Failed to open file for writing.")
  end
end

--



local function get_root(cwd)
  if not string.match(cwd, "^/home/kkpagaev") then
    return cwd
  end
  while cwd ~= "/home/kkpagaev" do
    for _, file in ipairs(root_files) do
      if vim.fn.filereadable(cwd .. "/" .. file) == 1 then
        return cwd
      end
    end

    for _, dir in ipairs(root_dirs) do
      if vim.fn.isdirectory(cwd .. "/" .. dir) == 1 then
        return cwd
      end
    end

    cwd = vim.fn.fnamemodify(cwd, ":h")
  end
end

local function set_root(root)
  vim.api.nvim_set_current_dir(root)
end

vim.keymap.set("n", ",c", function()
  local cwd = vim.fn.expand('%:p:h')
  local root = get_root(cwd)

  set_root(root)
end)

-- local function listvalues(s)
--     local t = { }
--     for k,v in ipairs(s) do
--         t[#t+1] = tostring(v)
--     end
--     return table.concat(t,"\n")
-- end


local function goto_root(index)
  local my_table = parse_file()
  local root = my_table[index]
  if not root then
    print("no root for index " .. index)
    return
  end
  set_root(root)

        if require("harpoon.mark").get_length() == 0 then
          require("telescope.builtin").find_files()
          return
        end
        vim.cmd('noh')
        ui.nav_file(1)
end

vim.keymap.set("n", "<leader><BS>", function()
  goto_root(1)
end)

vim.keymap.set("n", "<leader><C-h>", function()
  goto_root(1)
end)

vim.keymap.set("n", "<leader><C-t>", function()
  goto_root(2)
end)

vim.keymap.set("n", "<leader><Down>", function()
  goto_root(3)
end)

vim.keymap.set("n", "<leader><C-n>", function()
  goto_root(3)
end)

vim.keymap.set("n", "<leader><C-s>", function()
  goto_root(4)
end)

vim.keymap.set("n", "<leader>x", function()
  local cwd = vim.fn.expand('%:p:h')
  local root = get_root(cwd)
  vim.api.nvim_feedkeys(":! cd " .. root .. " && go run main.go", "n", true)
end)

vim.keymap.set("n", "<leader>!", function()
  local cwd = vim.fn.expand('%:p:h')
  local root = get_root(cwd)
  -- vim.api.nvim_feedkeys(":! cd " .. root .. " && yarn tsc", "n", true)
  print("building " .. root .. "...")
  local stdout = {}
  local job = vim.fn.jobstart(
    "yarn tsc --noErrorTruncation | awk '{ print $1 }' | sed 's/)://g' | sed 's/[\\(,\\,]/:/g'",
    {
        cwd = root,
        on_stdout = function (jobid, data, event)
          -- merge
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(stdout, line)
            end
          end

          -- print(vim.inspect(data))
        end,
          on_exit = function(jobid, code, event)
            print("finished")
            print(vim.inspect(stdout))
            local data = stdout

            if next(data) ~= nil then
              print(table.concat(data, "\n"))
              print("error")

              for i, line in ipairs(data) do
                data[i] = '"' .. line .. '"'
              end

              vim.cmd('cex [' .. table.concat(data, ", ") .. ']')
            else
              print("build successful for " .. root)
            end
          end
    }
  )
end)


vim.keymap.set("n", "<leader>pa", function()
  local my_table = parse_file()
  local cwd = vim.fn.expand('%:p:h')
  local root = get_root(cwd)

  for _, v in ipairs(my_table) do
    if root == v then
      print("already added")
      return
    end
  end

  table.insert(my_table, root)
  write_table_to_file(my_table)
end)

vim.keymap.set("n", "<leader>pf", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local projects = vim.fn.systemlist("find " .. git_root .. "/apps " .. git_root .. "/packages -maxdepth 1 -mindepth 1 -type d")

  -- print(vim.inspect(projects))


  -- our picker function: colors
  local colors = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = "colors",
      finder = finders.new_table {
        results = projects,
      },
       attach_mappings = function(prompt_bufnr, _)
      -- modifying what happens on selection with <CR>
        actions.select_default:replace(function()
        -- closing picker
        actions.close(prompt_bufnr)
        -- the typically selection is table, depends on the entry maker
        -- here { [1] = "one", value = "one", ordinal = "one", display = "one" }
        -- value: original entry
        -- ordinal: for sorting, possibly transformed value
        -- display: for results list, possibly transformed value
        local selection = action_state.get_selected_entry()
        local new_root = selection[1]

        set_root(new_root)

        if require("harpoon.mark").get_length() == 0 then
          require("telescope.builtin").find_files()
          return
        end
        vim.cmd('noh')
        ui.nav_file(1)
        -- do stuff
      end)
      -- keep default keybindings
      return true
    end,
      sorter = conf.generic_sorter(opts),
    }):find()
  end

  colors()
end)

vim.keymap.set("n", "<leader>ph", ":e ~/my_table.txt<cr>")
vim.keymap.set("n", "<leader>pp", function()
  -- print(vim.inspect(projects))
  local my_table = parse_file()


  -- our picker function: colors
  local colors = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = "colors",
      finder = finders.new_table {
        results = my_table,
      },
       attach_mappings = function(prompt_bufnr, _)
      -- modifying what happens on selection with <CR>
        actions.select_default:replace(function()
        -- closing picker
        actions.close(prompt_bufnr)
        -- the typically selection is table, depends on the entry maker
        -- here { [1] = "one", value = "one", ordinal = "one", display = "one" }
        -- value: original entry
        -- ordinal: for sorting, possibly transformed value
        -- display: for results list, possibly transformed value
        local selection = action_state.get_selected_entry()
        local new_root = selection[1]

        set_root(new_root)

        if require("harpoon.mark").get_length() == 0 then
          require("telescope.builtin").find_files()
          return
        end
        vim.cmd('noh')
        ui.nav_file(1)
        -- do stuff
      end)
      -- keep default keybindings
      return true
    end,
      sorter = conf.generic_sorter(opts),
    }):find()
  end

  colors()

end)

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     if not root then
--       return
--     end
--
--     vim.api.nvim_set_current_dir(root)
--     print(root)
--   end,
-- })

-- Define your table

-- Open a file in write mode

