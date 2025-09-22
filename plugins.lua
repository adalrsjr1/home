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

-- Color schemes should be loaded after plug#end().
-- We prepend it with 'silent!' to ignore errors when it's not yet installed.
-- vim.cmd('silent! colorscheme seoul256')
