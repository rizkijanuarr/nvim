local api = vim.api

-- General Settings
api.nvim_create_augroup("_general_settings", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    group = "_general_settings",
    callback = function()
        require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

api.nvim_create_autocmd("FileType", {
    group = "_general_settings",
    pattern = "qf",
    command = "set nobuflisted",
})

-- Git Settings
api.nvim_create_augroup("_git", { clear = true })
api.nvim_create_autocmd("FileType", {
    group = "_git",
    pattern = "gitcommit",
    command = "setlocal wrap spell",
})

-- Markdown Settings
api.nvim_create_augroup("_markdown", { clear = true })
api.nvim_create_autocmd("FileType", {
    group = "_markdown",
    pattern = "markdown",
    command = "setlocal wrap spell",
})

-- Auto Resize
api.nvim_create_augroup("_auto_resize", { clear = true })
api.nvim_create_autocmd("VimResized", {
    group = "_auto_resize",
    command = "tabdo wincmd =",
})

-- Alpha Settings
api.nvim_create_augroup("_alpha", { clear = true })
api.nvim_create_autocmd("User", {
    group = "_alpha",
    pattern = "AlphaReady",
    command = "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
})

-- Terminal Settings
api.nvim_create_augroup("neovim_terminal", { clear = true })
api.nvim_create_autocmd("TermOpen", {
    group = "neovim_terminal",
    command = "startinsert | set nonumber norelativenumber | nnoremap <buffer> <C-c> i<C-c>",
})

-- Function to Create Non-Existent Directory on BufWrite
local function MkNonExDir(file, buf)
    if vim.fn.empty(vim.fn.getbufvar(buf, "&buftype")) == 1 and not string.match(file, "^%w+://") then
        local dir = vim.fn.fnamemodify(file, ":h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end
end

api.nvim_create_augroup("BWCCreateDir", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
    group = "BWCCreateDir",
    callback = function(_)
        MkNonExDir(vim.fn.expand("<afile>"), vim.fn.expand("<abuf>"))
    end,
})
