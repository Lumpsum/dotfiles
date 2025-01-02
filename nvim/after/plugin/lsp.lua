local blink = require("blink.cmp")
local lspconfig = require("lspconfig")
local capabilities = blink.get_lsp_capabilities()
local lsp_zero = require('lsp-zero')

blink.setup({
    keymap = { preset = "default" },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    signature = {
        enabled = true,
        window = { border = 'single' },
    },

    completion = {
        menu = {
            border = 'single',
        },

        documentation = {
            window = { border = 'single' },
            auto_show = true,
            auto_show_delay_ms = 300
        }
    }
})

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
    nmap('gl', vim.diagnostic.open_float)

    nmap('<leader>rn', vim.lsp.buf.rename)
    nmap('<leader>ca', vim.lsp.buf.code_action)
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols)
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        vim.keymap.set('n', '<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
            { buffer = bufnr })
    end

    vim.lsp.inlay_hint.enable(false)
end

lsp_zero.extend_lspconfig({
    sign_text = true,
    lsp_attach = lsp_attach,
    capabilities = capabilities,
})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            hints = { enabled = true },
        }
    }
})

lspconfig.gopls.setup({
    on_attach = function(_, bufnr)
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = "*.go",
            callback = function()
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { "source.organizeImports" } }

                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                for cid, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
                vim.lsp.buf.format({ async = false })
            end
        })
    end,
    cmd = { "gopls" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
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

lspconfig.pylsp.setup({
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

lspconfig.rust_analyzer.setup({
    on_attach = function(_, bufnr)
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


lspconfig.terraformls.setup({})
lspconfig.tflint.setup({})

lspconfig.dockerls.setup({})

lspconfig.jsonls.setup({})

lspconfig.nil_ls.setup({})

lspconfig.yamlls.setup {
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

-- INFO: Keep for legacy
--
-- local cmp = require('cmp')
-- local luasnip = require('luasnip')
-- cmp.setup({
--     sources = {
--         { name = "nvim_lsp" },
--         { name = "nvim_lsp_signature_help" },
--         { name = "luasnip" },
--     },
--
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body)
--         end,
--     },
--
--     mapping = cmp.mapping.preset.insert({
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_locally_jumpable() then
--                 luasnip.expand_or_jump()
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--     }),
-- })


-- cmp.setup.filetype({ "sql" }, {
--     sources = {
--         { name = "vim-dadbod-completion" },
--         { name = "buffer" },
--     }
-- })

-- require("lspconfig").zls.setup({})

-- require('mason').setup({})
-- require('mason-lspconfig').setup({
-- --     ensure_installed = { "lua_ls", "pylsp", "gopls", "rust_analyzer", "terraformls", "tflint", "yamlls" },
--     handlers = {
--         function(server_name)
--             require('lspconfig')[server_name].setup({})
--         end,
--
--         lua_ls = function()
--             require("lspconfig").lua_ls.setup({
--                 settings = {
--                     Lua = {
--                         hints = { enabled = true },
--                     }
--                 }
--             })
--         end,
--
--     }
-- })
--
--         pylsp = function()
--             require "lspconfig".pylsp.setup({
--                 settings = {
--                     pylsp = {
--                         plugins = {
--                             -- formatter
--                             black = { enabled = true },
--                             autopep8 = { enabled = false },
--                             yapf = { enabled = false },
--                             -- linter
--                             ruff = {
--                                 enabled = true,
--                                 formatEnabled = true,
--                                 extendSelect = { "ALL" },
--                                 format = { "I" },
--                                 extendIgnore = { "D", "ANN101", "ANN204" },
--                             },
--                             pylint = { enabled = false },
--                             pyflakes = { enabled = false },
--                             pycodestyle = { enabled = false },
--                             -- type checker
--                             pylsp_mypy = { enabled = true },
--                             -- auto-completion
--                             jedi_completion = { fuzzy = true },
--                             -- auto import
--                             rope_autoimport = { enabled = false },
--                             -- import sorting
--                             pyls_isort = { enabled = false }
--                         },
--                     },
--                 },
--             })
--         end,
--
--         gopls = function()
--             require("lspconfig").gopls.setup({
--                 on_attach = function(client, bufnr)
--                     vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
--
--                     vim.api.nvim_create_autocmd('BufWritePre', {
--                         pattern = "*.go",
--                         callback = function()
--                             local params = vim.lsp.util.make_range_params()
--                             params.context = { only = { "source.organizeImports" } }
--
--                             local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
--                             for cid, res in pairs(result or {}) do
--                                 for _, r in pairs(res.result or {}) do
--                                     if r.edit then
--                                         local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
--                                         vim.lsp.util.apply_workspace_edit(r.edit, enc)
--                                     end
--                                 end
--                             end
--                             vim.lsp.buf.format({ async = false })
--                         end
--                     })
--                 end,
--                 cmd = { "gopls" },
--                 settings = {
--                     gopls = {
--                         completeUnimported = true,
--                         usePlaceholders = true,
--                         analyses = {
--                             unusedparams = true,
--                         },
--                         hints = {
--                             assignVariableTypes = true,
--                             compositeLiteralFields = true,
--                             compositeLiteralTypes = true,
--                             constantValues = true,
--                             functionTypeParameters = true,
--                             parameterNames = true,
--                             rangeVariableTypes = true,
--                         }
--                     }
--                 }
--             })
--         end,
--
--         rust_analyzer = function()
--             require("lspconfig").rust_analyzer.setup({
--                 on_attach = function(client, bufnr)
--                     vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
--                 end,
--                 settings = {
--                     ["rust-analyzer"] = {
--                         add_return_type = {
--                             enable = true,
--                         },
--                         inlayHints = {
--                             enable = true,
--                             showParameterName = true,
--                         },
--                     }
--                 }
--             })
--         end,
--
--         terraformls = function()
--             require('lspconfig').terraformls.setup({})
--         end,
--
--         tflint = function()
--             require('lspconfig').tflint.setup({})
--         end,
--
--         yamlls = function()
--             require('lspconfig').yamlls.setup {
--                 schemas = {
--                     kubernetes = "*.yaml",
--                     ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
--                     ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
--                     ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
--                     ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
--                     ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
--                     ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
--                     ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
--                     ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
--                     ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
--                     ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
--                     ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
--                     ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
--                 },
--             }
--         end,
--
--         dockerls = function()
--             require("lspconfig").dockerls.setup({})
--         end,
--
--         jsonls = function()
--             require("lspconfig").jsonls.setup({})
--         end,
--
--         nil_ls = function()
--             require("lspconfig").nil_ls.setup({})
--         end,
--     },
-- })
