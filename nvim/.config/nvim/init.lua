require('config.options')
require('config.keybinds')
require('config.lazy')
require('config.lsp')

local function requireDirectory(dir)
    local cwd = vim.fn.getcwd() .. "/" .. dir
    local files = vim.split(vim.fn.glob(cwd .. "/*"), '\n', {trimempty=true})

    for _, item in pairs(files) do
	local module = item:gsub('.*%/', '')
	module = module:gsub('.lua', '')
	require(dir .. '.' .. module)
    end
end

requireDirectory("lsp")
