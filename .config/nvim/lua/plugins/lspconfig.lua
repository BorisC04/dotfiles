return {
    'mason-org/mason.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
	'mason-org/mason-lspconfig.nvim',
	'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    opts = {
        servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            },
        },
    },
    config = function(_, opts)
        require('mason').setup()
	require('mason-lspconfig').setup({})
	require('mason-tool-installer').setup({
	    ensure_installed = {
		'lua_ls',
                'clangd',  -- C++
	    },
	})

        for server, config in pairs(opts.servers) do
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end

	 -- qmlls for quickshell needs to be setup this way to work
        -- vim.lsp.config('qmlls', {
        --     cmd = {'qmlls', '-E'},
        --     filetypes = { 'qml' }
        -- })
        -- vim.lsp.enable('qmlls')
    end
}

