local vim = vim

-- auto-install vim-plug plugin manager: https://github.com/junegunn/vim-plug
local data_dir = vim.fn.stdpath('data') .. '/site'
local plug_vim = data_dir .. '/autoload/plug.vim'

if vim.fn.empty(vim.fn.glob(plug_vim)) == 1 then
    vim.fn.system({'curl', '-fLo', plug_vim, '--create-dirs', 
                  'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
    vim.cmd('autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/plugins.lua')
end


local Plug = vim.fn['plug#']


-- https://github.com/junegunn/vim-plug
vim.call('plug#begin')

-- add plugins here
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

vim.call('plug#end')

local ok, cmp = pcall(require, "cmp")
if ok then
    cmp.setup {                          
        sources = {
            { name = 'nvim_lsp' }, -- for nvim-lsp
            { name = 'nvim_lua' }, -- for nvum lua function
            { name = 'path' },     -- for path completion
            { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
            { name = 'omni' },
        },
        completion = {
            keyword_length = 1,
            completeopt = "menu,noselect"
        },
        view = {
            entries = 'custom',
        },
        mapping = cmp.mapping.preset.insert({
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Esc>'] = cmp.mapping.close(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
        }),
    }
end

-- Color schemes should be loaded after plug#end().
-- We prepend it with 'silent!' to ignore errors when it's not yet installed.
-- vim.cmd('silent! colorscheme seoul256')
