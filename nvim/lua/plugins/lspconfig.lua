local lspconfig = require("lspconfig")
local typescript_ok, typescript = pcall(require, 'typescript')
local eslint_ok, eslint = pcall(require, 'eslint')

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
    if typescript_ok then
        typescript.setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            -- LSP Config options
            server = {
                capabilities = require('lsp.servers.tsserver').capabilities,
                handlers = require('lsp.servers.tsserver').handlers,
                on_attach = require('lsp.servers.tsserver').on_attach,
                settings = require('lsp.servers.tsserver').settings,
            }
        })
    end

    if eslint_ok then
        lspconfig.eslint.setup {
            capabilities = capabilities,
            handlers = handlers,
            on_attach = require("lsp.servers.eslint").on_attach,
            settings = require("lsp.servers.eslint").settings
        }
    end
end
