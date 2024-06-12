local dap = require('dap')

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end
map('n', '&', function()
  require'dap'.set_exception_breakpoints({"raised", "uncaught"})
end)

vim.fn.sign_define('DapBreakpoint',
  { text = '😡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',
  { text = '🔵', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
  { text = '👀', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<M-b>',
  function() require "dap".toggle_breakpoint() end)

vim.keymap.set('n', '<leader>cb',
  function() require "dap".clear_breakpoints() end)


vim.keymap.set({ 'n', 't' }, '<C-g>', function()
  require "dap".continue()
end)
vim.keymap.set({ 'n', 't' }, '<C-c>', function() require "dap".step_over() end)
vim.keymap.set({ 'n', 't' }, "<C-r>", function() require "dap".step_into() end)
vim.keymap.set({ 'n', 't' }, "<C-l>", function() require "dap".step_out() end)

vim.keymap.set({ "n", "i", "t" }, '<Left>', function()
  local bufname = vim.fn.expand("%:r")
  print(bufname)
  if bufname ~= "[dap-repl]" then
    -- require("dapui").toggle()
    vim.cmd("DapToggleRepl")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>j", true, true, true), "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
  else
    -- require("dapui").toggle()
    vim.cmd("DapToggleRepl")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", true)
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>j", true, true, true), "n", true)
  end
  -- focus_buffer("[dap-repl]")
end)

require("dap-vscode-js").setup({
  node_path = "node",                                                                          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/kkpagaev/vscode-js-debug",                                            -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- adapters = { 'pwa-node'}, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = function()
        -- require 'dap.utils'.pick_process({filter = "pnpm run start:debug"})
        require 'dap.utils'.pick_process()
      end,
      cwd = "${workspaceFolder}",
    }
  }
end

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}

require("dap").configurations.svelte = { -- change this to javascript if needed
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
    port = 9222,
    webRoot = "${workspaceFolder}",
  }
}


require("dap").configurations.vue = { -- change this to javascript if needed
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
    port = 9222,
    webRoot = "${workspaceFolder}",
  }
}

require("dap").configurations.typescriptreact = { -- change this to javascript if needed
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
    sourceMaps = true,
    trace = true,
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
}


-- require('dap-go').setup {
--   dap_configurations = {
--     {
--       -- Must be "go" or it will be ignored by the plugin
--       type = "go",
--       name = "Attach remote",
--       mode = "remote",
--       request = "attach",
--     },
--   },
--   delve = {
--     path = "dlv",
--     initialize_timeout_sec = 20,
--     port = "${port}",
--     args = {},
--     build_flags = "",
--   },
-- }

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/kkpagaev/Downloads/cpp/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "attach",
    processId = function()
      require 'dap.utils'.pick_process({filter = "gdb"})
    end,
    -- args = {"-n", "8", "-e", "gdb", "--oversubscribe", "./heap", "200"},
    -- args = {"200"},
    cwd = '${workspaceFolder}',
  },
  -- {
  --   name = 'Attach to gdbserver :1234',
  --   type = 'cppdbg',
  --   request = 'launch',
  --   MIMode = 'gdb',
  --   miDebuggerServerAddress = 'localhost:1234',
  --   miDebuggerPath = '/usr/bin/gdb',
  --   cwd = '${workspaceFolder}',
  --   program = function()
  --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --   end,
  -- },
}

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}

dap.configurations.rust = {
    -- {
    --     name = "hello-world",
    --     type = "lldb",
    --     request = "launch",
    --     program = function()
    --         return vim.fn.getcwd() .. "/target/debug/hello-world"
    --     end,
    --     cwd = "${workspaceFolder}",
    --     stopOnEntry = false,
    -- },
    {
        name = "hello-dap",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/rust-ts-json-compiler"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}


