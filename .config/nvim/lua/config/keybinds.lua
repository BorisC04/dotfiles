vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("LspConfig", {}),
    callback = function(ev)
        local opts = {buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<A-CR>", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end
})
