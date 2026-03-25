--local parser_dir = vim.fn.stdpath("data") .. "/treesitter"
--vim.fn.mkdir(parser_dir, "p")
--vim.opt.runtimepath:append(parser_dir)


require 'nvim-treesitter'.setup {
    -- parser_install_dir = parser_dir,

    -- A list of parser names, or "all"
    ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "php", "vim", "bash", "html", "css", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
}
