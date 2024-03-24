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
