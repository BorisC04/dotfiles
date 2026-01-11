return {
    { -- git plugin
	'tpope/vim-fugitive',
    },
    { -- CSS color
	'brenoprata10/nvim-highlight-colors',
	config = function()
	    require('nvim-highlight-colors').setup({})
	end
    },
}
