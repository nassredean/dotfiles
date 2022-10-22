local typescript_ok, typescript = pcall(require, 'typescript')

require("nvim-lsp-installer").setup {
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "sumneko_lua",
        "tsserver",
        "csharp_ls"
    },
    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
    automatic_installation = true
}

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

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
    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

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
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
        settings = require("lsp.servers.sumneko_lua").settings
    }

    lspconfig.csharp_ls.setup {
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
    }

    for _, server in ipairs {"bashls", "cssls", "html"} do
        lspconfig[server].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = handlers
        }
    end
end
