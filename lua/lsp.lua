local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
     --vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
  end,
},
window = {
   --completion = cmp.config.window.bordered(),
   --documentation = cmp.config.window.bordered(),
},
--completion = {
  --autocomplete = false;
--},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --['<C-Space>'] = cmp.mapping.complete(),
  ['<C-q>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
}),
formatting = {
  format = lspkind.cmp_format({
    mode = "symbol_text",
    menu = ({
      buffer = "[Buffer]",
      nvim_lsp = "[LSP]",
      vsnip = "[VSnip]",
      nvim_lua = "[Lua]",
      latex_symbols = "[Latex]",
    }),
    before = function (entry, item)
      function fit(text)
        if text then
          if text:len() > 40 then
            text = string.format("%-37s", text:sub(1,37)) .. "..."
          else
            text = string.format("%-40s", text)
          end
        end
        return text
      end
      item.abbr = fit(item.abbr)
      return item
    end
  }),
},
--formatting = {
  --fields = {'abbr', 'kind', 'menu'},
  --format = function(entry, item)
    --local menu_icon = {
      --nvim_lsp = 'λ',
      --vsnip = '⋗',
      --buffer = 'Ω',
      --path = '🖫',
    --}

    --item.menu = menu_icon[entry.source.name]
    --function fit(text)
      --if text then
        --if text:len() > 40 then
          --text = string.format("%-37s", text:sub(1,37)) .. "..."
        --else
          --text = string.format("%-40s", text)
        --end
      --end
      --return text
    --end
    --item.abbr = fit(item.abbr)
    --return item
  --end,
--}
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig['clangd'].setup {
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern(".git") or vim.fn.getcwd(),
}
lspconfig['lua_ls'].setup { capabilities = capabilities }
lspconfig['jedi_language_server'].setup { capabilities = capabilities }
-- disable inline error message
vim.diagnostic.config({virtual_text = false, signs = false})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = 'single'
  }
)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wl', function()
      --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

require "lsp_signature".setup({
    hint_enable = false,
})
