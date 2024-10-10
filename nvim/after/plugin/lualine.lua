require("lualine").setup {
    sections = {
        lualine_x = {
            function()
                if vim.fn.reg_recording() ~= '' then
                    return 'Recording @' .. vim.fn.reg_recording()
                else
                    return ''
                end
            end,
         }
    }
}
