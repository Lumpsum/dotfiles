vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>ps', require('telescope.builtin').grep_string, {})
vim.keymap.set('n', '<leader>pg', require('telescope.builtin').live_grep, {})
vim.keymap.set('n', '<leader>pd', require('telescope.builtin').diagnostics, {})
-- vim.keymap.set('n', '<leader>ps', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)

require("telescope").setup({
    pickers = {
        find_files = {
            -- hidden = true,
            -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
            find_files = {
                theme = "dropdown",
            }
        }
    }
})

pcall(require('telescope').load_extension, 'fzf')
