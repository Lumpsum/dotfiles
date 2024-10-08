return {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-emoji',
        },
        --
        -- opts = function(_, opts)
        --     local has_words_before = function()
        --         unpack = unpack or table.unpack
        --         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        --         return col ~= 0 and
        --             vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        --     end
        --     local luasnip = require("luasnip")
        --     local cmp = require("cmp")
        --
        --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
        --         ["<Tab>"] = cmp.mapping(function(fallback)
        --             -- If it's a snippet then jump between fields
        --             if luasnip.expand_or_jumpable() then
        --                 luasnip.expand_or_jump()
        --                 -- otherwise if the completion pop is visible then complete
        --             elseif cmp.visible() then
        --                 cmp.confirm({ select = false })
        --                 -- if the popup is not visible then open the popup
        --             elseif has_words_before() then
        --                 cmp.complete()
        --                 -- otherwise fallback
        --             else
        --                 fallback()
        --             end
        --         end, { "i", "s" }),
        --     })
        -- end,
    },
}
