local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("dap-go").setup()

require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

vim.keymap.set("n", "<space>dc", dap.continue)
vim.keymap.set("n", "<space>ds", dap.step_over)
vim.keymap.set("n", "<space>di", dap.step_into)
vim.keymap.set("n", "<space>do", dap.step_out)
vim.keymap.set("n", "<space>db", dap.step_back)
vim.keymap.set("n", "<space>dr", dap.restart)

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end
