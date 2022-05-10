require("nvim-lsp-installer").setup {
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "graphql",
        "html",
        "jsonls",
        "sumneko_lua",
        "tailwindcss",
        "tsserver",
        "vetur",
        "vuels"
    },
    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
    automatic_installation = true
}
local lspconfig = require("lspconfig")

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
            border = "rounded"
        }
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = "rounded"
        }
    )
}

local function on_attach(client, bufnr)
    -- set up buffer keymaps, etc.
end

local on_ts_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

    lspconfig.eslint.setup {
        capabilities = capabilities,
        handlers = handlers,
        on_attach = require("lsp.servers.eslint").on_attach,
        settings = require("lsp.servers.eslint").settings
    }

    lspconfig.jsonls.setup {
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
        settings = require("lsp.servers.jsonls").settings
    }

    lspconfig.sumneko_lua.setup {
        handlers = handlers,
        on_attach = on_attach,
        settings = require("lsp.servers.sumneko_lua").settings
    }

    local tscapabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    tscapabilities.textDocument.completion.completionItem.snippetSupport = true
    tscapabilities.textDocument.completion.completionItem.preselectSupport = true
    tscapabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    tscapabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    tscapabilities.textDocument.completion.completionItem.deprecatedSupport = true
    tscapabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    tscapabilities.textDocument.completion.completionItem.tagSupport = {
        valueSet = {1}
    }
    tscapabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {"documentation", "detail", "additionalTextEdits"}
    }
    tscapabilities.textDocument.codeAction = {
        dynamicRegistration = false,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = {
                    "",
                    "quickfix",
                    "refactor",
                    "refactor.extract",
                    "refactor.inline",
                    "refactor.rewrite",
                    "source",
                    "source.organizeImports"
                }
            }
        }
    }

    -- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
    require("typescript").setup(
        {
            disable_commands = false, -- prevent the plugin from creating Vim commands
            disable_formatting = false, -- disable tsserver's formatting capabilities
            debug = false, -- enable debug logging for commands
            -- LSP Config options
            server = {
                capabilities = tscapabilities,
                handlers = handlers,
                on_attach = on_ts_attach
            }
        }
    )

    for _, server in ipairs {"bashls", "cssls", "html"} do
        lspconfig[server].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers
        }
    end
end
