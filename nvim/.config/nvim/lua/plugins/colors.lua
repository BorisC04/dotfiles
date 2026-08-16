local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
end

return {
    {
	"folke/tokyonight.nvim",
        opts = {
            style = "night",
            on_colors = function(colors)
            end,
            on_highlights = function(hl, colors)
                hl.LineNrAbove = { fg = colors.dark3 }
                hl.LineNrBelow = { fg = colors.dark3}
            end,
        },
	config = function(_, opts)
            require("tokyonight").setup(opts)
	    vim.cmd.colorscheme "tokyonight"
	    enable_transparency()
	    vim.o.termguicolors = true
	end,
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    theme = 'tokyonight',
	}
    },
}
