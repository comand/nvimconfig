local servers = {
    'clangd',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'ruff_lsp',
}

require'mason'.setup()
require'mason-lspconfig'.setup({
  ensure_installed = servers,
})
require'mason-null-ls'.setup({
  automatic_setup = true
})

local lspconfig = require'lspconfig'

require("user.lsp.handlers").setup()
for _, server in pairs(servers) do
  local opts = {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities
  }
  local has_custom_opts, server_custom_opts = pcall(require, 'user.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', opts, server_custom_opts)
    --[[ print(server) ]]
    --[[ print(vim.inspect(opts)) ]]
  end
  lspconfig[server].setup(opts)
end
