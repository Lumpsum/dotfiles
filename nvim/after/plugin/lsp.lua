local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    }),

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

})
cmp.setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,

        require "lspconfig".lua_ls.setup({
            settings = {
                Lua = {
                    hints = { enabled = true },
                }
            }
        }),

        pylsp = function()
            require "lspconfig".pylsp.setup({
                capabilities = lsp_capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            -- formatter
                            black = { enabled = true },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },
                            -- linter
                            ruff = {
                                enabled = true,
                                formatEnabled = true,
                                extendSelect = { "ALL" },
                                format = { "I" },
                                extendIgnore = { "D", "ANN101", "ANN204" },
                            },
                            pylint = { enabled = false },
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            -- type checker
                            pylsp_mypy = { enabled = true },
                            -- auto-completion
                            jedi_completion = { fuzzy = true },
                            -- auto import
                            rope_autoimport = { enabled = false },
                            -- import sorting
                            pyls_isort = { enabled = false }
                        },
                    },
                },
            })
        end,

        gopls = function()
            require("lspconfig").gopls.setup({
                on_attach = function(client, bufnr)
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end,
                settings = {
                    gopls = {
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        }
                    }
                }
            })
        end,

        rust_analyzer = function ()
            require("lspconfig").rust_analyzer.setup({
                on_attach = function(client, bufnr)
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end,
                settings = {
                    ["rust-analyzer"] = {
                        add_return_type = {
                            enable = true,
                        },
                        inlayHints = {
                            enable = true,
                            showParameterName = true,
                        },
                    }
                }
            })
        end,

        terraformls = function()
            require('lspconfig').terraformls.setup({})
        end,

        tflint = function()
            require('lspconfig').tflint.setup({})
        end,

        yamlls = function()
            require('lspconfig').yamlls.setup {
                schemas = {
                    kubernetes = "*.yaml",
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                    ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                    ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                    ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                },
            }
        end,

        dockerls = function()
            require("lspconfig").dockerls.setup({})
        end,

        jsonls = function()
            require("lspconfig").jsonls.setup({})
        end,
    },
})

-- Auto format on save
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     buffer = bufnr,
--     callback = function()
--         vim.lsp.buf.format({ async = false })
--     end,
-- })
