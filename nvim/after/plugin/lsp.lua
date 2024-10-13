local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('K', vim.lsp.buf.hover)
    -- nmap('<C-K>', vim.lsp.buf.signature_help)

    nmap('gd', vim.lsp.buf.definition)
    nmap('gD', vim.lsp.buf.declaration)
    nmap('gi', vim.lsp.buf.implementation)
    nmap('go', vim.lsp.buf.type_definition)
    nmap('gr', require('telescope.builtin').lsp_references)
    nmap('gs', vim.lsp.buf.signature_help)
    nmap('gq', vim.lsp.buf.format)

    nmap('<leader>rn', vim.lsp.buf.rename)
    nmap('<leader>ca', vim.lsp.buf.code_action)
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols)
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        vim.keymap.set('n', '<leader>th', function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { buffer = bufnr })
    end

    vim.lsp.inlay_hint.enable(false)
end

lsp_zero.extend_lspconfig({
    sign_text = true,
    lsp_attach = lsp_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
    },

    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({}),
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "pylsp", "gopls", "rust_analyzer", "terraformls", "tflint", "yamlls" },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        hints = { enabled = true },
                    }
                }
            })
        end,

        pylsp = function()
            require "lspconfig".pylsp.setup({
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
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
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

        rust_analyzer = function()
            require("lspconfig").rust_analyzer.setup({
                on_attach = function(client, bufnr)
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
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

