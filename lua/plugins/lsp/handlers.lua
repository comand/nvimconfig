local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    width = 60,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
  })
end

local function lsp_highlight_document(client)
  local status_ok, illuminate = pcall(require, 'illuminate')
  if status_ok then
    illuminate.on_attach(client)
  end
end

local function lsp_keymaps(bufnr)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
  end

  nmap('<leader>rn', vim.lsp.buf.rename, 'LSP: [r]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'LSP: [c]ode [a]ction')

  nmap('gd', vim.lsp.buf.definition, 'LSP: [g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, 'LSP: [g]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'LSP: type [d]efinition')
  nmap('gi', vim.lsp.buf.implementation, 'LSP: [g]oto [i]mplementation')
  nmap('gr', require'telescope.builtin'.lsp_references, 'LSP: references')
  nmap('<leader>ds', require'telescope.builtin'.lsp_document_symbols, 'LSP: [d]ocument [s]ymbols')
  nmap('<leader>ws', require'telescope.builtin'.lsp_dynamic_workspace_symbols, 'LSP: [w]orkspace [s]ymbols')

  nmap('K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature Documentation')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format({async=true})
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  if client.server_capabilities.documentSymbolProvider then
    local has_navic, navic = pcall(require, 'nvim-navic')
    if has_navic then
      navic.attach(client, bufnr)
    end
  end
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
