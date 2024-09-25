require("filetype").setup({
    overrides = {
        extensions = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "terraform"
        }
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        require("cmp").setup.buffer({
            sources = { { name = "vim-dadbod-completion" } }
        })
    end
})
