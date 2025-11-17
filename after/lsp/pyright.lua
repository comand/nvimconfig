return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = true
  end,

  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' }, -- using Ruff for linting
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'off',
        diagnosticMode = 'off',
      },
    },
  },
}
