return {
    "barrettruth/live-server.nvim",
    cmd = { "LiveServerStart", "LiveServerStop"},
    conifg = function()
        vim.g.live_server= {
            port = 8080,
            browser = true,
        }
    end
}
