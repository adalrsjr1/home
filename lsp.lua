local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
    capabilities = require('cmp_nvim_lsp').default_capabilities()
end

-- Create augroup for better management
local lsp_augroup = vim.api.nvim_create_augroup('LSPConfig', { clear = true })

-- LSP key mappings and configuration
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    -- Set omnifunc
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Insert mode completion triggers
    vim.keymap.set('i', '<c-space>', '<c-x><c-o>', { buffer = bufnr })
    vim.keymap.set('i', '.,', '<c-x><c-o>', { buffer = bufnr })

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr })
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { buffer = bufnr })
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { buffer = bufnr })

    -- LSP keymaps
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Close preview window when completion is done
vim.api.nvim_create_autocmd('CompleteDone', {
  group = lsp_augroup,
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd.pclose()
    end
  end
})

-- Configure LSP servers with proper capabilities
-- Go language server
lspconfig.gopls.setup {
  capabilities = capabilities,
}

-- Python servers configuration
-- Disable Ruff's completion to avoid duplicates with Pyright
lspconfig.ruff.setup {
  capabilities = vim.tbl_extend('force', capabilities, {
    completionProvider = false, -- Disable completion to avoid duplicates
  }),
  init_options = {
    settings = {
      -- Add any Ruff-specific settings here
    }
  }
}

-- Pyright configuration
lspconfig.pyright.setup {
  capabilities = capabilities,
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Use Ruff for import organization
    },
    python = {
      analysis = {
        ignore = { '*' }, -- Use Ruff for linting
        typeCheckingMode = "off", -- Optional: if you want Ruff for type checking too
      },
    },
  },
}

-- Optional: Global diagnostics configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Optional: Sign configuration for diagnostics
local signs = { Error = "🔴", Warn = "🟡", Hint = "🔵", Info = "⚪" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Modern auto completion

local ok, cmp = pcall(require, "cmp")
if ok then
    cmp.setup {
        sources = {
            { name = 'nvim_lsp' }, -- for nvim-lsp
            { name = 'nvim_lua' }, -- for nvim lua function
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


