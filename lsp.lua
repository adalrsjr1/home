local lspconfig = require("lspconfig")

local autocmd = vim.api.nvim_create_autocmd

-- use LspAttach autocommand to only map the follwing keys after the language
-- server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = {buffer = args.buf}
        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.keymap.set('i', '<c-space>', '<c-x><c-o>')
        vim.keymap.set('i', '.,', '<c-x><c-o>')

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', 'd]', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        vim.keymap.set('n', '<c-space>', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- close Window Preview when popup is close
vim.api.nvim_create_autocmd('CompleteDone', {
    callback = function(args)
        if vim.fn.pumvisible() == 0 then
            vim.cmd.pclose()
        end
    end
})


vim.lsp.enable('gopls')


vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright, otherwise auto-complete doesn't work
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

require('lspconfig').pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
}
vim.lsp.enable('pyright')

vim.lsp.config('ruff', {
    init_options = {
        settings = {
            -- Ruff language server settings go here
        }
    }
})
vim.lsp.enable('ruff')

