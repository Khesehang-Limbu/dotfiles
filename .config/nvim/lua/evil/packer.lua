-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd.packadd('packer.nvim')

return require('packer').startup(
    function(use)
        -- Packer can manage itself
        use 'dart-lang/dart-vim-plugin'
        use 'thosakwe/vim-flutter'
        use 'natebosch/vim-lsc'
        use 'natebosch/vim-lsc-dart'
        use 'wbthomason/packer.nvim'
        use 'ThePrimeagen/vim-be-good'
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.4',
            -- or                            , branch = '0.1.x',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }

        use({
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        })

        use({
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup {
                    icons = false,
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        })

        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end, }
        use("nvim-treesitter/playground")
        use("theprimeagen/harpoon")
        use("theprimeagen/refactoring.nvim")
        use("mbbill/undotree")
        use("tpope/vim-fugitive")
        use("nvim-treesitter/nvim-treesitter-context");

        use('williamboman/mason.nvim')
        use('neovim/nvim-lspconfig')
        use('williamboman/mason-lspconfig.nvim')
        use('hrsh7th/nvim-cmp')
        use('hrsh7th/cmp-buffer')
        use('hrsh7th/cmp-path')
        use('saadparwaiz1/cmp_luasnip')
        use('hrsh7th/cmp-nvim-lsp')
        use('hrsh7th/cmp-nvim-lua')
        use{'L3MON4D3/LuaSnip',
            run = 'make install_jsregexp'
        }
        use('rafamadriz/friendly-snippets')

        use("folke/zen-mode.nvim")
        use("eandrju/cellular-automaton.nvim")
        use("laytan/cloak.nvim")

        use("mfussenegger/nvim-dap")
        use("nvim-neotest/nvim-nio")

        use {
            "rcarriga/nvim-dap-ui",
            requires = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio"
            },
            config = function()
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup()

                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open()
                end

                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close()
                end

                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close()
                end
            end
        }

        use {
            "mfussenegger/nvim-dap-python",
            ft = "python",
            config = function(_, opts)
                local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
                require("dap-python").setup(path)
            end
        }
    end
)
