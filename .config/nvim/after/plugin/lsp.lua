require("mason").setup()

vim.cmd([[
    autocmd BufNewFile,BufRead *.html setlocal filetype=htmldjango
]])

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    }
})

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-k>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.config.disable,
    ['<S-Tab>'] = cmp.config.disable,
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp_mappings,
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Normal mode mappings
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)

    -- Insert mode mappings
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "html", "pylsp", "ruff" },
    automatic_installation = true,
})

-- pylsp setup
vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            -- disable to avoid conflicts with ruff
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            mccabe = { enabled = false },
            pylsp_mypy = { enabled = false },

            -- jedi for completions/definitions
            jedi_completion = { enabled = true },
            jedi_hover = { enabled = true },
            jedi_references = { enabled = true },
            jedi_signature_help = { enabled = true },
            jedi_symbols = { enabled = true },
        }
    }
})


-- lua_ls config
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            }
        }
    }
})


vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" })

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
