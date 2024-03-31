local bufferline = require("bufferline")
bufferline.setup({
  options = {
    separator_style = "slant",
    style_preset = bufferline.style_preset.no_italic,
    numbers = "ordinal"
  }
})
-- disable netrw for nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  filesystem_watchers = {
    enable = false
  },
  hijack_directories = {
    auto_open = false,
  },
  actions = {
    use_system_clipboard = false,
  }
})
require("mason").setup()
require("nvim-surround").setup()
require("neodev").setup() -- must before lsp
require('nvim-autopairs').setup({
  break_undo = false
})
require('lsp')

-- set lsp semantic highlighting
local links = {
  ['@lsp.type.namespace'] = '@type',
  ['@lsp.type.type'] = '@type',
  ['@lsp.type.class'] = '@type',
  ['@lsp.type.enum'] = '@type',
  ['@lsp.type.interface'] = '@type',
  ['@lsp.type.struct'] = '@type',
  --['@lsp.type.parameter'] = '@parameter',
  ['@lsp.type.variable'] = '@normal',
  ['@lsp.type.property'] = '@normal',
  ['@lsp.type.enumMember'] = '@normal',
  ['@lsp.type.function'] = '@function',
  ['@lsp.type.method'] = '@function',
  ['@lsp.type.macro'] = '@function',
  ['@lsp.type.decorator'] = '@function',
  ['@lsp.type.operator'] = '@operator',
}
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end
