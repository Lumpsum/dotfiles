-- vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<cr>", { buffer = 0})
vim.keymap.set("n", "<leader>mt", function ()
    require("markview").commands.toggle()
end, { buffer = 0})
