return {
    'neovim/nvim-lspconfig',
    dependencies = {
	'mason-org/mason.nvim',
	'mason-org/mason-lspconfig.nvim',
	'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
	require('mason').setup({})
	require('mason-lspconfig').setup({})
	require('mason-tool-installer').setup({
	    ensure_installed = {
		'lua_ls',
		'qmlls',
	    },
	})

	-- qmlls for quickshell needs to be setup this way to work
	-- vim.lsp.config('qmlls', {
	--     cmd = {'qmlls', '-E'},
	--     filetypes = { 'qml' }
	-- })
	-- vim.lsp.enable('qmlls')
    end
}
