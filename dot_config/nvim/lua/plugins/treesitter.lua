return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
	local config = require('nvim-treesitter')
	config.install {
	    'c',
	    'lua',
	    'vim',
	    'vimdoc',
	    'query',
	    'markdown',
	    'markdown_inline',
	    'json',
	    'bash',
	    'hyprlang'
	}
	config.setup({
	    hightlight = {
		enable = true,
	    },
	    indent = { enable = true },
	    autotage = { enable = true },
	    ensure_installed = {
	    },
	    auto_install = false
	})
	vim.api.nvim_create_autocmd( 'FileType', {
	    pattern = { '<fileType>'},
	    callback = function() vim.treesitter.start()
	    vim.wo[0][0].fooldexpr = 'v:lua.vim.treesitter.foldexpr()'
	    vim.wo[0][0].foldmethod = 'expr'
	    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	    end,
	})
    end
}
